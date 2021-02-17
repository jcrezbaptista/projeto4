<%-- 
    Document   : recebeDadosReceita
    Created on : 16/12/2020, 08:05:39
    Author     : entra21
--%>

<%@page import="utils.ConversorData"%>
<%@page import="java.sql.Date"%>
<%@page import="Modelos.Receita"%>
<%@page contentType="text/html charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //verifica sessão
    String usuario = (String) session.getAttribute("usuario");
    int idUser = (int) session.getAttribute("idUser");
    if (usuario == null) {
        response.sendRedirect("login.jsp");
    }

    //instancia e recebe os valores da tela HTML
    Receita receita = new Receita();
    receita.setIdUsuario(idUser);
    receita.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));
    receita.setDescricao(request.getParameter("descricao"));

    String valor = request.getParameter("valor");
    valor = valor.replace(".", "");
    valor = valor.replace(',', '.');

    receita.setValor(ConversorData.formataMoeda((request.getParameter(valor))));
    receita.setData(Date.valueOf(request.getParameter("data")));

    String msg = "";
    if (receita.salvar()) {
        msg = "A sua  nova Renda foi salva com sucesso!";
    } else {
        msg = "Problemas ao salvar a sua nova Renda!";
    }
    response.sendRedirect("informacao.jsp?msg=" + msg);
%>
