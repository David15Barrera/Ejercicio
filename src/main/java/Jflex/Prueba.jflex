/* primer seccion: codigo de usuario */

package com.mycompany.ejerciciojflex;

%%

/* segunda seccion: configuracion */

%class Prueba
%public
%line
%column
%int

%state PALABRA
(a|e|i|o|u|A|E|I|O|U)
[a-zA-Z]|[0-9] 
espacio=[\s,\t,\r,\n]+

%{
    private StringBuffer Palabra = new StringBuffer();

    private String[] palabrasUnaVocal = new String[0];
    private String[] palabrasDosVocales = new String[0];
    private String[] palabrasTresVocales = new String[0];
    private String[] palabrasCuatroVocales = new String[0];
    private String[] palabrasCincoVocales = new String[0];
    
    private int[][] posicionesDigitos = new int[0][2];

    private int countVocalesPalabra =  0;
    
    private void iniciarPalabra(){
        yybegin(PALABRA);
        Palabra.append(yytext());
    }
    
    private void terminarPalabra(){
        agregarPalabra();
        limpiarBuffer();
    }
    
    private void limpiarBuffer(){
        Palabra.delete(0, bufferPalabra.length());
    }
    
    private String[] agregarPalabra(String palabra, String[] arreglo){
        String[] temp = new String[arreglo.length+1];
        for(int i=0; i<arreglo.length; i++){
            temp[i] = arreglo[i];
        }
        temp[temp.length-1] = palabra;
        return temp;
    }
    
    private void agregarPosicionDigito(int linea, int columna){
        int[][] temp = new int[posicionesDigitos.length+1][2];
        for(int i=0; i<posicionesDigitos.length; i++){
            temp[i][0] = posicionesDigitos[i][0];
            temp[i][1] = posicionesDigitos[i][1];
        }
        temp[temp.length-1][0] = linea;
        temp[temp.length-1][1] = columna;
        posicionesDigitos = temp;
    }

    public String[] getUnaVocal(){
        return palabrasUnaVocal;
    }

    public String[] getDosVocales(){
        return palabrasDosVocales;
    }

    public String[] getTresVocales(){
        return palabrasTresVocales;
    }

    public String[] getCuatroVocales(){
        return palabrasCuatroVocales;
    }

    public String[] getCincoVocales(){
        return palabrasCincoVocales;
    }
    
    public int[][] getPosicionesDigitos(){
        return posicionesDigitos;
    }
%}
 
%eof{
    terminarPalabra();
%eof}
 
%%

/*tercer seccion: reglase lexicas*/

    (a|e|i|o|u|A|E|I|O|U) {Palabra.append(yytext());countVocalesPalabra++;}
    ([a-zA-Z]|[0-9]) {iniciarPalabra();}
    {espacio} {agregarPalabra();}


    [^] {}
 

