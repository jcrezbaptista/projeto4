/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;


import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Calendar;
import java.util.Locale;
/**
 *
 * @author entra21
 */
public class ConversorData {
    public static java.sql.Date conv(Calendar d){
       java.sql.Date data = new java.sql.Date(d.getTime().getTime());
       return data;
    }
    
public static String formataMoeda(float valor) {
        DecimalFormat formatoDois = new DecimalFormat("##,###,###,##0.00", new DecimalFormatSymbols(new Locale("pt", "BR")));
        formatoDois.setMinimumFractionDigits(2);
        formatoDois.setParseBigDecimal(true);

        return formatoDois.format(valor);
    }
}
