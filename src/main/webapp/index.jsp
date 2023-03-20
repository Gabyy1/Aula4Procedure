<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Procedure</title>
</head>
<body>
	<div align="center" class="cointainer">
		<form action="cliente" method="post">
			<p class="title">
				<b>Cliente</b>
			</p>
			<table>
				<tr>
					<td>
						<input class="input_data" type="number" min="0" step="1" id="cpf" name="cpf" placeholder="#CPF">
					</td>
					</tr>
					<tr>
					<td>
						<input class="input_data" type="text" id="nome" name="nome" placeholder="Nome">
					</td>
					</tr>
					<tr>
					<td>
						<input class="input_data" type="text" id="email" name="email" placeholder="Email">
					</td>
					</tr>
					<tr>
					<td>
						<input class="input_data" type="number" min="0" step="0.01" id="limite" name="limite" placeholder="Limite">
					</td>
					</tr>
					<tr>
					<td>
						<input class="input_data" type="date" id="nasc" name="nasc" placeholder="Nascimento">
					</td>
					</tr>
					<tr>
					<td>
						<input type="submit" id="botao" name="botao" value="Inserir">
					</td>
					</tr>
					<tr>
					<td>
						<input type="submit" id="botao" name="botao" value="Atualizar">
					</td>
					</tr>
					<tr>
					<td>
						<input type="submit" id="botao" name="botao" value="Deletar">
					</td>
					</tr>
					
			</table>
		</form>
	</div>
	<br />
	<div align="center">
		<H2><c:out value="${erro }" /></H2>
	</div>
	<div align="center">
		<H3><c:out value="${saida }" /></H3>
	</div>
</body>
</html>