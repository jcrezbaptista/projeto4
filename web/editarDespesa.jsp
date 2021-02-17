<%-- 
    Document   : cadastroDespesa
    Created on : 13/12/2020, 20:01:48
    Author     : User
--%>

<%@page import="utils.ConversorData"%>
<%@page import="java.sql.Date"%>
<%@page import="Modelos.Despesa"%>
<%@page import="java.util.List"%>
<%@page import="Modelos.Categoria"%>
<%@page contentType="text/html charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Minha Agenda Financeira</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style/estilos.css">    
    </head>
    <body style="background-color:rgba(0, 0, 242, 0.1)">   
        <header>
            <div class="logo"><img src="imagens/logo.png"></div>
        </header>
        <div class="login">
            <img src="imagens/avatar.jpg" style="width:66px">
            <p> Olá,
                <%
                    String nomeUser = (String) session.getAttribute("nome");
                    out.write(nomeUser);
                %> !!
            </p>
            <div class="topnav a">
                <a href="#"><img src="imagens/envelope.png"></i> </a>
                <a href="login.jsp"><img src="imagens/usuario.png"></i></a>
                <a href="cadastroCategoriaDefault.jsp"><img src="imagens/configura.png"></i></a>
            </div>
        </div>   
        <div class="painel"> Painel de Controle </div><br>   
        <div class="menu">
            <div class="clearfix">
                <div class="column">
                    <ul>
                        <li><a class="link" href="menu.jsp" ><img src="imagens/menu.png" hspace="4">  MENU </a></li>
                        <li><a class="link" href="cadastroDespesa.jsp"><img src="imagens/gasto.png" hspace="3">  Seu novo Gasto</a> </li>
                        <li><a class="link" href="cadastroReceita.jsp"><img src="imagens/renda.png" hspace="3">  Sua nova Renda</a></li>
                        <li><a class="link" href="cadastroCategoria.jsp"><img src="imagens/categoria.png" hspace="3">   Crie nova Categoria</a></li>
                        <li><a class="link" href="consultaBalancete.jsp"><img src="imagens/resumo.png" hspace="3">  Resumo Financeiro</a></li>
                        <li><a class="link" href="consultaUsuario.jsp"><img src="imagens/usuario.png" hspace="3">  Meus Dados</a></li>
                        <li><a class="link" href="consultaCategoriaDefault.jsp"><img src="imagens/configura.png" hspace="3">  Configurações</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="cadcat1"><h2 style="text-align: center">Faça Alteração dos Dados</h2>
            <br>
            <%
                int id = Integer.parseInt(request.getParameter("id"));
                int idUser = Integer.parseInt(request.getParameter("idUser"));
                Despesa despesa = new Despesa();
                Categoria categoria = new Categoria();
                List<Categoria> categorias = null;
                if (id != 0 && idUser != 0) {
                    despesa = despesa.consultar(id, idUser);
                    categorias = categoria.consultar(idUser, "D");  //consulta as categorias tipo=DESPESA
                }
            %>
            <div>
                <form action="recebeEditaDespesa.jsp" method="POST">
                    <input type="hidden" name="id" value="<%out.write("" + despesa.getId());%>">
                    <label>Informe a Categoria</label>
                    <select name="idCategoria"><% for (Categoria c : categorias) { %>
                        <% if (c.getId() == despesa.getIdCategoria()) { %>
                        <option value="<%out.write("" + c.getId());%>"><%out.write(c.getDescricao());%></option>
                        <%}%>
                        else { %>
                        <option value="<%out.write("" + c.getId());%>">
                            <%out.write(c.getDescricao());%></option>
                            <% } %>
                    </select> 
                    <br>
                    <br>
                    <label>Informe a Descrição</label>
                    <input type="text" name="descricao" value="<%out.write(despesa.getDescricao());%>"/> 
                    <br>
                    <br>
                    
                    <label>Informe o Valor</label>
                    <input type="text" name="valor" onkeyup="formatarMoeda()" />

                    <br>
                    <br>
                    <label>Informe a Data</label>
                    <input type="date" name="data" value="<%out.write(String.valueOf(despesa.getData()));%>"/>
                    <br>
                    <br>
                    <input class="cancelar" type="button" value="Alterar" onclick="enviaForm()" />
                </form>
            </div>
            <script>
         function formatarMoeda() {
            var elemento = document.getElementById('valor');
            var valor = elemento.value;

            valor = valor + '';
            valor = parseInt(valor.replace(/[\D]+/g, ''));
            valor = valor + '';
            valor = valor.replace(/([0-9]{2})$/g, ",$1");

            if (valor.length > 6) {
                valor = valor.replace(/([0-9]{3}),([0-9]{2}$)/g, ".$1,$2");
            }
            debugger;
            if (valor != "NaN"){
                elemento.value = valor;
            }
            else{
                elemento.value = "";
            }
        }

    function enviaForm() {
                    /*var descricao = document.getElementsByName("descricao");
                     if (descricao[0].value === "") {
                     descricao[0].focus();
                     alert("informe a descricao");
                     exit();
                     }*/
                    var valor = document.getElementsByName("valor");
                    if (valor[0].value === "") {
                        valor[0].focus();
                        alert("informe o valor");
                        exit();
                    }
                    var data = document.getElementsByName("data");
                    if (data[0].value === "") {
                        data[0].focus();
                        alert("informe a data");
                        exit();
                    }

                    document.forms[0].submit();
                }
             
                        </script>
        </div>   
        <div class="final">
            <p> <strong>C</strong> - 2021 - Desenvolvido nas aulas de Java da Turma Maturitech</p>
        </div> 
    </body>
</html>
