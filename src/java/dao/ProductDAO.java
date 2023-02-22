/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import db.DBContext;
import dto.Account;
import dto.Product;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Thinh Tran
 */
public class ProductDAO {

    public List<Product> getListProducts() throws SQLException, Exception {
        String query = "select TOP 12 * from SanPham";
        ArrayList<Product> list = new ArrayList<>();
        Connection con = null;
        DBContext db = new DBContext();
        con = db.getConnection();

        java.sql.Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery(query);
        while (rs.next()) {
            Product product = new Product();
            product.setId(rs.getString("maSP"));
            product.setName(rs.getString("tenSP"));
            product.setImg(rs.getString("hinhDD"));
            product.setDescription(rs.getString("ndTomTat"));
            product.setDatePublic(rs.getDate("ngayDang"));
            product.setIdCategory(rs.getInt("maLoai"));
            product.setPrice(rs.getString("giaBan"));
            product.setDiscount(rs.getString("giamGia"));

            list.add(product);
        }
        con.close();

        return list;
    }

    public static void main(String[] args) throws Exception {
        ProductDAO dao = new ProductDAO();
        ArrayList<Product> list = (ArrayList<Product>) dao.getListProducts();
        for (Product pro : list) {
            System.out.println(pro.getImg());
        }
    }
}
