package model;


public class Cliente {
	int cpf;
	String nome;
	String email;
	float limite;
	String nasc;
	
	public int getCpf() {
		return cpf;
	}
	public void setCpf(int cpf) {
		this.cpf = cpf;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public float getLimite() {
		return limite;
	}
	public void setLimite(float limite) {
		this.limite = limite;
	}
	public String getNasc() {
		return nasc;
	}
	public void setNasc(String nasc) {
		this.nasc = nasc;
	}
	@Override
	public String toString() {
		return "Cliente [cpf=" + cpf + ", nome=" + nome + ", email=" + email + ", limite=" + limite + ", nasc=" + nasc
				+ "]";
	}
}
