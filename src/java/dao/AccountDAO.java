/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import db.DBContext;
import dto.Account;
import java.beans.Statement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Thinh Tran
 */
public class AccountDAO {

    public List<Account> select() throws SQLException, Exception {
        ArrayList<Account> list = new ArrayList<>();
        Connection con = null;
        DBContext db = new DBContext();
        con = db.getConnection();
        
            java.sql.Statement stm = con.createStatement();
            ResultSet rs = stm.executeQuery("select * from TaiKhoan");
            while (rs.next()) {
                Account acc = new Account();
                acc.setUserName(rs.getString("taiKhoan"));
                acc.setPassWord(rs.getString("matKhau"));
                acc.setLastName(rs.getString("hoDem"));
                acc.setFirstName(rs.getString("tenTV"));
                acc.setBirthDay(rs.getDate("ngaysinh"));
                acc.setGender(rs.getBoolean("gioiTinh"));
                acc.setPhoneNumber(rs.getString("soDT"));
                acc.setEmail(rs.getString("email"));
                acc.setAddress(rs.getString("diaChi"));
                acc.setIsActive(rs.getBoolean("trangThai"));
                acc.setRole(rs.getString("vaitro"));
                acc.setNote(rs.getString("ghiChu"));
                list.add(acc);
            }
            con.close();
      
        return list;
    }
    
    public static void main(String[] args) throws Exception {
        AccountDAO dao = new AccountDAO();
        ArrayList<Account> list = (ArrayList<Account>) dao.select();
        for (Account acc : list){
            System.out.println(acc);
        }
    }
}
