package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import model.Cliente;

public class ClienteDao implements IClienteDao {
	private GenericDao gDao;


	public ClienteDao(GenericDao gDao) {
		this.gDao = gDao;
	}

	@Override
	public String insereCliente(Cliente cl) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		
		String sql = "{CALL sp_cliente(?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setInt(1, cl.getCpf());
		cs.setString(2, cl.getNome());
		cs.setString(3, cl.getEmail());
		cs.setFloat(4, cl.getLimite());
		cs.setDate(5, cl.getNasc());
		cs.registerOutParameter(6, Types.VARCHAR);
		cs.execute();
		
		String saida = cs.getString(6);
		
		cs.close();
		c.close();
		
		return saida;
	}



}
