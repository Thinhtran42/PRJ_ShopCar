<%-- 
    Document   : product
    Created on : Feb 21, 2023, 1:07:48 PM
    Author     : Thinh Tran
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix ="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="product" class="dao.ProductDAO" scope="request"/>
<section class="py-5">
    <div class="container px-4 px-lg-5 mt-5">
        <div class="row justify-content-center">

            <c:forEach var="i" items="${product.listProducts}">
                <div class="text-center col-md-4 mb-4">
                    <div class="card h-100">
                        <img style="height: 200px" class="card-img-top img-fluid rounded shadow  " src="${i.img}" alt="..." />
<!--                        <p class="card-text">${i.description}</p>-->
                        <div class="card-body p-4">
                            <div class="text-center fs-6 text">
                                <p class="card-text">${i.description}</p>
                                <h5 class="card-title">${i.name}</h5>

                                Product reviews
                                <div class="d-flex justify-content-center small text-warning mb-2">
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                    <div class="bi-star-fill"></div>
                                </div>
                                ${i.price}
                            </div>
                        </div>
                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                            <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                        </div>
                    </div>
                </div>
            </c:forEach>             
        </div>
    </div>
    <!--    pagination-->
    <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-center text-right">
            <li class="page-item disabled">
                <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item">
                <a class="page-link" href="#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>
    <!--    pagination-->
</section>