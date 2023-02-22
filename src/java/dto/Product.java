/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import java.sql.Date;

/**
 *
 * @author Thinh Tran
 */
public class Product {
    private String id;
    private String name;
    private String img;
    private String description;
    private Date datePublic;
    private int idCategory;
    private String price;
    private String discount;

    public Product() {
    }

    public Product(String id, String name, String img, String description, Date datePublic, int idCategory, String price, String discount) {
        this.id = id;
        this.name = name;
        this.img = img;
        this.description = description;
        this.datePublic = datePublic;
        this.idCategory = idCategory;
        this.price = price;
        this.discount = discount;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDatePublic() {
        return datePublic;
    }

    public void setDatePublic(Date datePublic) {
        this.datePublic = datePublic;
    }

    public int getIdCategory() {
        return idCategory;
    }

    public void setIdCategory(int idCategory) {
        this.idCategory = idCategory;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", name=" + name + ", img=" + img + ", description=" + description + ", datePublic=" + datePublic + ", idCategory=" + idCategory + ", price=" + price + ", discount=" + discount + '}';
    }
}
