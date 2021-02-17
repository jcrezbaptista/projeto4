<%-- 
    Document   : recebeDadosDespesa
    Created on : 16/12/2020, 08:05:39
    Author     : entra21
--%>

<%@page import="utils.ConversorData"%>
<%@page import="java.sql.Date"%>
<%@page import="Modelos.Despesa"%>
<%@page contentType="text/html charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color:rgba(0, 0, 242, 0.1)">
    <head>
        <title>Minha Agenda Financeira</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style/estilos.css">
        <link rel="stylesheet" href="style/estilos.css">

    </head>
    <body>
        <header>
            <div class="logo"><img src="imagens/logo.png"></div>
        </header>
        <%
            //verifica sessão
            String usuario = (String) session.getAttribute("usuario");
            int idUser = (int) session.getAttribute("idUser");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            }

            //instancia e recebe os valores da tela HTML
            Despesa despesa = new Despesa();
            despesa.setIdUsuario(idUser);
            despesa.setIdCategoria(Integer.parseInt(request.getParameter("idCategoria")));
            despesa.setDescricao(request.getParameter("descricao"));

            String valor = request.getParameter("valor");
            valor = valor.replace(".", "");
            valor = valor.replace(',', '.');

            despesa.setValor(ConversorData.formataMoeda((request.getParameter(valor))));
            despesa.setData(Date.valueOf(request.getParameter("data")));

            String msg = "";
            if (despesa.salvar()) {
                msg = "O seu novo Gasto foi salvo com sucesso!";
            } else {
                msg = "Problemas ao salvar o seu novo Gasto!";
            }
            response.sendRedirect("informacao.jsp?msg=" + msg);
        %>

        <footer>
            <i class="final"><img src="imagens/icon-c.png" > - 2021 - Desenvolvido nas aulas de Java da Turma Maturitech </i>
        </footer>   
    </body>
</html>