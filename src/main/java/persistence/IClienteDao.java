package persistence;

import java.sql.SQLException;

import model.Cliente;

public interface IClienteDao {
	public String insereCliente(Cliente c) throws SQLException, ClassNotFoundException;

}
