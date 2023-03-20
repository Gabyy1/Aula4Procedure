package controller;

import java.io.IOException;
import java.sql.SQLException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Cliente;
import persistence.ClienteDao;
import persistence.GenericDao;

@WebServlet("/cliente")
public class ClienteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ClienteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Cliente cl = new Cliente();
		
		String cpf = request.getParameter("cpf");
		String nome = request.getParameter("nome");
		String email =request.getParameter("email");
		String limite = request.getParameter("limite");
		String nasc =request.getParameter("nasc");
		
		
		cl = validaCliente (cpf, nome, email, limite, nasc);
		String erro = "";
		String saida = "";
		try {
			if(cl == null) {
				erro = "preencha os campos corretamente";
			}else {
				GenericDao gDao = new GenericDao();
				ClienteDao clDao = new ClienteDao(gDao);
				saida = clDao.insereCliente(cl);
			}
			
		}catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
			
		}finally {
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			request.setAttribute("saida", saida);
			request.setAttribute("erro", erro );
			rd.forward(request, response);
			
		}
	}

	private Cliente validaCliente(String cpf, String nome, String email, String limite, String nasc) {
		Cliente cl = new Cliente();
		
		if(cpf.equals("") || (nome.equals("")) || (email.equals("")) || (limite.equals("")) || (nasc.equals(""))) {
			cl = null;
		}else {
			cl.setCpf(Integer.parseInt(cpf));
			cl.setNome(nome);
			cl.setEmail(email);
			cl.setLimite(Float.parseFloat(limite));
			cl.setNasc(nasc);		
				
	}
	
	return cl;

	}

}
