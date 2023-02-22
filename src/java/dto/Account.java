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
public class Account {
    private String userName;
    private String passWord;
    private String lastName;
    private String firstName;
    private Date birthDay;
    private boolean gender;
    private String phoneNumber;
    private String email;
    private String address;
    private boolean isActive;
    private String role;
    private String note;

    public Account() {
    }

    public Account(String userName, String passWord, String lastName, String firstName, Date birthDay, boolean gender, String phoneNumber, String email, String address, boolean isActive, String role, String note) {
        this.userName = userName;
        this.passWord = passWord;
        this.lastName = lastName;
        this.firstName = firstName;
        this.birthDay = birthDay;
        this.gender = gender;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.isActive = isActive;
        this.role = role;
        this.note = note;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public Date getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(Date birthDay) {
        this.birthDay = birthDay;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "Account{" + "userName=" + userName + ", passWord=" + passWord + ", lastName=" + lastName + ", firstName=" + firstName + ", birthDay=" + birthDay + ", gender=" + gender + ", phoneNumber=" + phoneNumber + ", email=" + email + ", address=" + address + ", isActive=" + isActive + ", role=" + role + ", note=" + note + '}';
    }
    
    
    
}
