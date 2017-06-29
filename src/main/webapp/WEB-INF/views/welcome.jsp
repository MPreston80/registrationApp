<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: kamel
  Date: 1/12/2017
  Time: 3:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script language="JavaScript">

        function checkForm(form) {

            var elements = document.getElementsByTagName('span');
            if(elements.length>0){
                for(var i = 0;i < elements.length;i++){
                    elements[i].innerHTML = '';
                }
            }

            var firstNm = form.fname.value;
            var lastName = form.lname.value;
            var address = form.address1.value;
            var address2 = form.address2.value;
            var city = form.city.value;
            var state = form.state.value;
            var zipcd = form.zip.value;
            var country = form.country.value;
            var errorCount = 0;

            var numCheck = /\d/g;
            var otherCheck = /[!@$~`%^&*()_+\-=\[\]{};':"\\|,<>\/?]+/g;
            var zipCheck = /[!@#$~`%^&*()_+=\[\]{};':"\\|,<>\/?]+/g;
            var letterCheck = /[a-zA-Z]/g;

            if(firstNm ==""||firstNm.length>30||firstNm.match(numCheck)||firstNm.match(otherCheck)){
                var firstError = document.getElementById("one");
                firstError.innerHTML = "Invalid entry! Field must be 1-30 characters, letters only";
                errorCount = errorCount + 1;

            }

            if(lastName ==""||lastName.length>30||lastName.match(numCheck)||lastName.match(otherCheck)){
                var secondError = document.getElementById("two");
                secondError.innerHTML = "Invalid entry! Field must be 1-30 characters, letters only";
                errorCount = errorCount + 1;

            }

            if(address ==""||address.length>50||address.match(otherCheck)){
                var thirdError = document.getElementById("three");
                thirdError.innerHTML = "Invalid entry! Field must have min. 1 character max 50 characters";
                errorCount = errorCount + 1;
            }

            if(address2.length>50||address2.match(otherCheck)){
                var fourthError = document.getElementById("four");
                fourthError.innerHTML = "Invalid entry! Field must have min. 1 character max 50 characters";
                errorCount = errorCount + 1;
            }

            if(city==""||city.length>40||city.match(numCheck)||city.match(otherCheck)){
                var fifthError = document.getElementById("five");
                fifthError.innerHTML = "Invalid entry! Field must be 1-40 characters, letters only";
                errorCount = errorCount + 1;
            }

            if(state==""||state.length<2||state.length>20||state.match(numCheck)||state.match(otherCheck)){
                var sixthError = document.getElementById("six");
                sixthError.innerHTML = "Invalid entry! Field must be 1-20 characters, letters only";
                errorCount = errorCount + 1;
            }

            if(zipcd==""||(zipcd.length!=5&&zipcd.length!=10)||zipcd.match(zipCheck)||zipcd.match(letterCheck)){
                if(zipcd.length===10&&zipcd.charAt(5)!="-"){
                    var seventhError = document.getElementById("seven");
                    seventhError.innerHTML = "Invalid entry! Field must contain either 5 or 9 digits. '-' between 5th and 6th number";
                    errorCount = errorCount + 1;
                }
                else{
                    var seventhError = document.getElementById("seven");
                    seventhError.innerHTML = "Invalid Entry! Field must contain 5 or 9 digits";
                    errorCount = errorCount + 1;
                }
            }

            if(!(country==="United States"||country==="US"||country==="U.S."||country==="USA"||country==="united states"||country==="U.S.A."
               ||country==="us"||country==="u.s."||country==="u.s.a.")){
                var eighthError = document.getElementById("eight");
                eighthError.innerHTML = "Invalid Entry! The only valid entry for this field is United States";
                errorCount = errorCount + 1;
            }


            if(errorCount>0){
                return false;
            }

            else{
                return true;
            }
        }

    </script>
</head>
<body>
<form action="registerUser" method = "post" onsubmit="return checkForm(this)">
    First Name: <input type = "text" name = "fname" placeholder="${form.get(0)}"><span style = "color:red" id = "one"></span><br>
    Last Name: <input type = "text"  name = "lname" placeholder="${form.get(1)}"><span style = "color:red" id = "two"></span><br>
    Address 1: <input type = "text" name = "address1" placeholder="${form.get(2)}"><span style = "color:red" id = "three"></span><br>
    Address 2: <input type = "text" name = "address2" placeholder="${form.get(3)}"><span  style = "color:red"id = "four"></span><br>
    City: <input type = "text" name = "city" placeholder="${form.get(4)}"><span style = "color:red" id = "five"></span><br>
    State: <input type = "text" name = "state" placeholder="${form.get(5)}"><span style = "color:red" id = "six"></span><br>
    Zip Code: <input type = "text" name = "zip" placeholder="${form.get(6)}"><span style = "color:red" id = "seven"></span><br>
    Country: <input type = "text" name = "country" placeholder="${form.get(7)}"><span style = "color:red" id = "eight"></span><br>



    <input type = "submit" value = "Register"><br><br>
    <h3>${message}</h3>

    <div style = "color:red">
        <c:forEach var = "i" items = "${listErrors}">
        <c:out  value = "${i}"/><br>
        </c:forEach>
    </div>

</form>




</body>
</html>
