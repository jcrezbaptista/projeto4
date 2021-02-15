<%-- 
    Document   : consultaDespesaDetalhada
    Created on : 08/02/2021, 10:35:42
    Author     : entra21
--%>

<%@page import="utils.ConversorData"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Despesa"%>
<%@page import="java.util.List"%>
<%@page import="Modelos.Categoria"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="background-color:rgba(0, 0, 242, 0.1)">
     <head>
        <title>Minha Agenda Financeira</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style/estilos.css">
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <link rel="stylesheet" href="style/estilos.css">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
      
    </head>
    <body>
       <header>
            <div class="logo"><img src="imagens/logo.png"></div>
        </header>
       
        <div class="login">
        <img src="imagens/avatar.jpg" style="width:76px">
        <h3> Olá,
            <% 
              String nomeUser = (String) session.getAttribute("nome");
              out.write(nomeUser);
            %> !!
        </h3>
        <div class="topnav a">
            <a href="#"><i class="fa fa-envelope"></i> </a>
            <a href="#"><i class="fa fa-user"></i></a>
            <a href="#"><i class="fa fa-cog"></i></a>
        </div>
        </div>
        
        <div class="painel"> Painel de Controle </div><br>
        <div class="menu">
        <div class="clearfix">
        <div class="column">
        <ul>
            <li><a href="menu.jsp" ><i class="fa fa-users fa-fw"></i>  MENU </a></li>
            <li><a href="cadastroDespesa.jsp"><i class="fas fa-comments-dollar"></i>  Seu novo Gasto</a> </li>
            <li><a href="cadastroReceita.jsp"><i class="fas fa-donate"></i>  Sua nova Renda</a></li>
            <li><a href="cadastroCategoria.jsp"><i class="fas fa-clipboard"></i>  Crie nova Categoria</a></li>
            <li><a href="consultaBalancete.jsp"><i class="fas fa-balance-scale"></i>  Resumo Financeiro</a></li>
            <li><a href="#"><i class="fa fa-bell fa-fw"></i>  Meus Dados</a></li>
            <li><a href="#"><i class="fa fa-cog fa-fw"></i>  Configurações</a></li>
        </ul>
        </div>
        </div>
        </div>
 
        <%
            
            //verifica sessão
            String usuario = (String) session.getAttribute("usuario");
            int idUser = (int) session.getAttribute("idUser");
            if (usuario == null) {
                response.sendRedirect("login.jsp");
            }
        %>   


        <div class="container4"><h1>Consulta Despesa Detalhada</h1>
        
        <form action="consultaDespesaDetalhada.jsp" method="POST">
            
                <label>Digite a Data Inicial</label>
                <input style="width: 50%" type="date" name="dataInicio" />
                <br>

                <label>Digite a Data Final</label>
                <input style="width: 50%" type="date" name="dataFim" />
                <br>

                
                <%
                    Categoria cat = new Categoria();
                    //List<Categoria> categorias = cat.consultar(idUser);
                     List<Categoria> categorias = cat.consultar(idUser, "D");
                %>

                <input type="checkbox" name="filtrarByCategoria"> Filtrar por categoria?</input>
                <select style="width: 50%" name="categoria">
                    <%for (Categoria ct : categorias) { %>
                    <option value=<%out.write("" + ct.getId());%>><%out.write(ct.getDescricao());%></option>
                    <%}%>
                </select>
                <br> 
                
                <label>Agrupar?</label>
                <input type="checkbox" name="agrupar" checked="true" />
                
                <input class="consultar" type="button" value="Consultar"  onclick="enviaForm()"/>
               
  </form> 
               
        </div>
            <%
                Despesa despesa = new Despesa();
                List<Despesa> despesas = new ArrayList<>();
                //Integer idUser = (int) session.getAttribute("idUser");
               // Integer idUser = 7;
                String filtrarByCategoria = request.getParameter("filtrarByCategoria");
                String categoria = request.getParameter("categoria");
                // String valor = request.getParameter("valor");
                // String data = request.getParameter("data");
                String inicio = request.getParameter("dataInicio");
                String fim = request.getParameter("dataFim");
                String agrupar = request.getParameter("agrupar");
                if (inicio != null && fim != null) {
                    Date dataInicio = Date.valueOf(inicio);
                    Date dataFim = Date.valueOf(fim);
                    boolean agrupa = false;
                    if (agrupar != null) {
                        agrupa = true;
                    }
                    //busca por categoria
                    if (filtrarByCategoria != null) {
                        int idCategoria = Integer.parseInt(categoria);
                        despesas = despesa.consultaLancamentosByIntervaloData(idUser, dataInicio, dataFim, agrupa, idCategoria);
                    } else {
                        despesas = despesa.consultaLancamentosByIntervaloData(idUser, dataInicio, dataFim, agrupa);
                    }
                }
            %> 


            <%
                if (inicio == null && fim == null) {
                    out.write("<table style='display:none'>");
                } else {
                    if (inicio.isEmpty() && fim.isEmpty()) {
                        out.write("<table style='display:none'>");
                    } else {
                        out.write("<table style='display:block'>");
                    }
                }
            %>
            
            <table class="container5">   
            <thead>
            <th>Descricao</th>
            <th>Valor</th>
            <th>Data</th> 
        </thead> 
        <tbody>
            <% for (Despesa d : despesas) {%>

            <tr>
                <td><% out.write(d.getDescricao());%></td>
                <td><% out.write(String.valueOf(ConversorData.formataMoeda(d.getValor())));%></td>
                <td><% out.write(String.valueOf(d.getData()));%></td>        
            </tr>
            <%}%>
        </tbody>  
        
    </table>
         
<script>
                    function enviaForm() {
                        debugger;
                        var dataInicio = document.getElementsByName("dataInicio")[0];
                        if (dataInicio.value === "") {
                            dataInicio.focus();
                            alert("Informe data de Inicio");
                            return;
                        }
                        var dataFim = document.getElementsByName("dataFim")[0];
                        if (dataFim.value === "") {
                            dataFim.focus();
                            alert("Informe data de Final");
                            return;
                        }
                        document.forms[0].submit();
                    }
</script>

<div class="final">
    <i><img src="imagens/icon-c.png" > - 2021 - Desenvolvido nas aulas de Java da Turma Maturitech </i>
</div>              

</body>
</html>
