Create DataBase Aula4
Go
Use Aula4
Go

Create Table cliente (
cpf			char(11)		not null,
nome		varchar(100)	not null,
email		varchar(200)	not null,
limite		decimal(7,2)	not null,	
nasc		date			not null
Primary Key (CPF)
)

Create Procedure sp_cliente_valida_tamanho_cpf (@cpf char(11), @valido Bit Output)
As
	Declare @tamanho_cpf int
	Set @tamanho_cpf =  Len(@cpf)
	If (@tamanho_cpf = 11)
	Begin
		Set @valido = 1
	End
	Else
	Begin
		Set @valido = 0
	End 

Create Procedure sp_cliente_valida_cpf_num_iguais (@cpf char(11), @valido_iguais Bit Output)	
As
	If(@cpf = '00000000000' Or @cpf = '11111111111' Or @cpf = '22222222222' Or @cpf =
		'33333333333' Or @cpf = '44444444444' Or @cpf = '55555555555' Or @cpf =
		'66666666666' Or @cpf = '77777777777' Or @cpf = '88888888888' Or @cpf =
		'99999999999')
	Begin
		Set @valido_iguais = 0
	End
	Else
	Begin
		Set @valido_iguais = 1
	End

Create Procedure sp_cliente_valida_cpf_digito1 (@cpf char(11), @valido_dig1 Bit Output)
As
	Declare @conta_cpf int,
			@cont int,
			@aux varchar
	Set @aux = Substring(@aux, 1, 9)
	Set @cont = 2
	Set @conta_cpf = 0
	While (@cont <= 10)
	Begin
	Set @conta_cpf = @conta_cpf + (@cont * Cast(Substring(@aux, 11 - @cont, 1) as int))
	Set @cont = @cont + 1
	Set @conta_cpf = @conta_cpf - (@conta_cpf/11)*11
	If (@conta_cpf <= 1)
		Set @conta_cpf = 0
	Else
		Set @conta_cpf = 11 - @conta_cpf
		Set @aux = @aux + Cast(@conta_cpf As Varchar(1))
    End
	If (@aux = SUBSTRING(@cpf, 1, 10))
		Set @valido_dig1 = 1
	Else 
	Begin
		Set @valido_dig1 = 0
	End

Create Procedure sp_cliente_valida_cpf_digito2 (@cpf char(11), @valido_dig2 Bit Output)
As
	Declare @conta_cpf2 int,
			@cont2 int,
			@aux varchar
	Set @aux = Substring(@aux, 1, 9)
	Set @conta_cpf2 = 0
	Set @cont2 = 2
	While (@cont2 <= 11)
	Begin
		Set @conta_cpf2 = @conta_cpf2 + (@cont2 * Cast(Substring(@aux, 12 - @cont2, 1) As int))
		Set @cont2 = @cont2 + 1
	Set @conta_cpf2 = @conta_cpf2 - (@conta_cpf2/11)*11
	If(@conta_cpf2 < 2)
		Set @conta_cpf2 = 0
	Else 
		Set @conta_cpf2 = 11 - @conta_cpf2
		Set @aux = @aux + Cast(@conta_cpf2 As Varchar(1))
	End
	If (@aux = @cpf)
		Set @valido_dig2 = 1
	Else 
	Begin
		Set @valido_dig2 = 0
	End

Create Procedure sp_cliente (@op Char(1), @cpf Varchar(100), @nome varchar(100), @email varchar(200), 
					@limite decimal(7,2), @nasc date, @saida varchar(200) output)
As
	Declare 

		If (Upper(@op)='D' or (@op)= 'd' and @cpf is not null)
	Begin
		Delete cliente Where cpf = @cpf
		Set @saida = 'Cliente CPF: ' +Cast(@cpf As Varchar(11))+ ' excluído'
	End
	Else
	Begin
		If (Upper(@op)='D' or (@op)= 'd' and @cpf is null)
	Begin
		Raiserror('CPF não pode ser nulo', 16,1)
	End
	Else
	Begin
		Exec sp_cliente_valida_tamanho_cpf @cpf, @valido_tam output
		Print @valido_tam
		Exec sp_cliente_valida_cpf_num_iguais @cpf, @valido_iguais output
		Print @valido_iguais 
		Exec sp_cliente_valida_cpf_digito1 @cpf, @valido_dig1 output
		Print @valido_dig1
		Exec sp_cliente_valida_cpf_digito2 @cpf, @valido_dig2 output
		Print @valido_dig2

		If (@valido_tam = 0 Or @valido_iguais = 0 Or @valido_dig1 = 0 Or @valido_dig2 = 0)
	Begin
		Raiserror ('CPF inválido', 16, 1)
	End
	Else
		If (Upper(@op) = 'I' Or (@op)='i')
	Begin
		Insert Into cliente Values (@cpf, @nome, @email, @limite, @nasc)
		Set @saida = 'Cliente cadastrado'
	End
	Else
	Begin
		If (Upper(@op) = 'U' Or (@op)='u')
	Begin
		Update cliente
		Set nome = @nome, email = @email, limite = @limite, nasc = @nasc
		Where cpf =  @cpf
		Set @saida = 'Cliente CPF: ' + Cast(@cpf As varchar(11)) + ' atualizado'
	End
	Else
	Begin
		Raiserror('Operação inválida', 16, 1)
	End
	End
	End
	End
