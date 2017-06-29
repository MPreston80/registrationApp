package com.test.controller;

import com.test.Models.Users;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.sql.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.regex.Pattern;

@Controller
public class HomeController {

    @RequestMapping("/")

    public ModelAndView helloWorld()
    {
        return new
                ModelAndView("welcome","" ,"");

    }

    @RequestMapping("/admin")

    public ModelAndView adminReport()
    {
        return new
                ModelAndView("administrative","displayUsers", getUsers());
    }

    public String getDate()
    {

        Calendar cal = Calendar.getInstance();

        int year = cal.get(Calendar.YEAR);
        String newYear=String.valueOf(year);

        int month = cal.get(Calendar.MONTH);
        month = month + 1;
        String newMonth = String.valueOf(month);

        int day = cal.get(Calendar.DATE);
        String newDay = String.valueOf(day);
        String date = newYear + "-" + newMonth + "-" + newDay;

        return date;
    }

    public ArrayList<Users> getUsers()
    {

        String selectUsers = "select * from users order by RegistrationDate desc";
        String url = "jdbc:mysql://localhost:3306/helloworld";
        String userName = "root";
        String password = access.passWord;
        try {
            Class.forName("com.mysql.jdbc.Driver");

            Connection c = DriverManager.getConnection(url,userName,password);

            Statement st = c.createStatement();

            ResultSet rs =st.executeQuery(selectUsers);
            ArrayList<Users> usersList = new ArrayList<Users>();

            while (rs.next())
            {
                String first = rs.getString(2);
                String last = rs.getString(3);
                String address1 = rs.getString(4);
                String address2 = rs.getString(5);
                String city = rs.getString(6);
                String state = rs.getString(7);
                String zip = rs.getString(8);
                String country = rs.getString(9);
                String date = rs.getString(10);
                Users temp = new Users(first,last,address1,address2,city,state,zip,country,date);

                usersList.add(temp);

            }
            return usersList;
        }
        catch(Exception ex)
        {
            return null;
        }


    }


    public ArrayList<String> validateInput(String first, String last, String firstAddress, String secondAddress,
                                           String city, String state, String zip, String country){


        ArrayList<String> list = new ArrayList<String>();
        list.clear();
        first = first.replaceAll(" ", "");
        last = last.replaceAll(" ", "");
        city = city.replaceAll(" ", "");
        state = state.replaceAll(" ", "");
        zip = zip.replaceAll("-","");


        System.out.println(zip);
        if((!Pattern.matches("[a-zA-Z]+", first))||first.length()>30||first.length()<1){
            list.add("The first name field must contain letters only and have 1-30 characters");
        }

        if((!Pattern.matches("[a-zA-Z]+", last))||last.length()>30||last.length()<1){
            list.add("The last name field must contain letters only and have 1-30 characters");
        }

        if(firstAddress.length()<1||firstAddress.length()>50){
            list.add("Address 1 field must be greater than 1 but less than 50 characters");
        }

        if(secondAddress.length()>50){
            list.add("Address 2 field must be less than 50 characters");
        }

        if((!Pattern.matches("[a-zA-Z]+", city))||city.length()>40||city.length()<1){
            list.add("City field must contain letters only and have 1-40 characters");
        }

        if((!Pattern.matches("[a-zA-Z]+", state))||state.length()>20||state.length()<1){
            list.add("The state field must contain letters only and have 1-20 characters");
        }

        if((!zip.matches("[0-9]+"))||(zip.length()!=5&&zip.length()!=9)){
            list.add("Zip code field must contain either 5 or 9 digits");
        }

        if(!(country.equalsIgnoreCase("US")||country.equalsIgnoreCase("United States")||country.equalsIgnoreCase("USA"))){
            list.add("Please enter 'US' in the country field");
        }

        return list;

    }

    @RequestMapping("registerUser")

    public String registerUser(@RequestParam("fname") String firstName, @RequestParam("lname")  String lastName,
                               @RequestParam("address1") String add1, @RequestParam("address2") String add2,
                               @RequestParam("city") String city, @RequestParam("state") String state, @RequestParam("zip") String zip,
                                @RequestParam("country") String country, Model model) throws ClassNotFoundException, SQLException {

        ArrayList<String> errors = validateInput(firstName,lastName,add1,add2,city,state,zip,country);

        ArrayList<String> formInput = new ArrayList<String>();



        formInput.add(firstName);
        formInput.add(lastName);
        formInput.add(add1);
        formInput.add(add2);
        formInput.add(city);
        formInput.add(state);
        formInput.add(zip);
        formInput.add(country);

        //If there are errors, run this code and take back to registration form.
        if(errors.size()>0){
            model.addAttribute("listErrors", errors);
            model.addAttribute("form", formInput);
            model.addAttribute("message", "Please fix the following errors and resubmit:");
            return "welcome";
        }

        //Else, complete registration and store data.
        else{

            String date = getDate();

            String url = "jdbc:mysql://localhost:3306/helloworld";
            String username = "root";
            String password = access.passWord;
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement pst = con.prepareStatement("insert into users(FirstName, LastName, Address1, Address2, City, State, Zip, Country, RegistrationDate)" + "values(?,?,?,?,?,?,?,?,?)");

            pst.setString(1, firstName);
            pst.setString(2, lastName);
            pst.setString(3, add1);
            pst.setString(4, add2);
            pst.setString(5, city);
            pst.setString(6, state);
            pst.setString(7, zip);
            pst.setString(8, country);
            pst.setString(9, date);

            pst.executeUpdate();
            pst.close();
            con.close();


            model.addAttribute("message",firstName);
            return "registrationSuccess";
        }







    }

}
