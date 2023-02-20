# Importante: No modificar ni el nombre ni los argumetos que reciben las funciones, sólo deben escribir
# código dentro de las funciones ya definidas.

# Recordar utilizar la ruta relativa, no la absoluta para ingestar los datos desde los CSV
# EJ: 'datasets/xxxxxxxxxx.csv'
import pandas as pd
import numpy as np

def Ret_Pregunta01():
    '''
    Debes utilizar Pandas para ingestar en un objeto Dataframe el contenido del archivo provisto
    "Fuentes_Consumo_Energia.csv".
    Esta función debe informar la cantidad de registros cuya entidad sean Colombia o México retornando ese valor en un dato
    tupla (Colombia, México).
    Pista averiguar la funcion Shape
    '''
    #Tu código aca:

    df = pd.read_csv("datasets/Fuentes_Consumo_Energia.csv")
    
    colombia= df[df['Entity'].isin(['Colombia'])].shape
    mexico= df[df['Entity'].isin(['Mexico'])].shape

    return (colombia[0],mexico[0])

def Ret_Pregunta02():
    '''
    Debes utilizar Pandas para ingestar en un objeto Dataframe el contenido del archivo provisto
    "Fuentes_Consumo_Energia.csv".
    Esta función debe eliminar las columnas 'Code' y 'Entity' y luego informar la cantidad de columnas
    retornando ese valor en un dato de tipo entero.
    '''
    #Tu código aca:

    df = pd.read_csv("./datasets/Fuentes_Consumo_Energia.csv")

    df.drop(["Code"], axis="columns", inplace= True)
    df.drop(["Entity"], axis="columns", inplace= True)
    cantidad_columnas = df.shape

    return cantidad_columnas[1] 

def Ret_Pregunta03():
    '''
    Debes utilizar Pandas para ingestar en un objeto Dataframe el contenido del archivo provisto
    "Fuentes_Consumo_Energia.csv".
    Esta función debe informar la cantidad de registros de la columna Year sin tener en cuenta aquellos con valores faltantes
    retornando ese valor en un dato de tipo entero.
    '''
    df = pd.read_csv("./datasets/Fuentes_Consumo_Energia.csv")
    

    return df['Year'].dropna().shape[0]

def Ret_Pregunta04():
    '''
    Debes utilizar Pandas para ingestar en un objeto Dataframe el contenido del archivo provisto
    "Fuentes_Consumo_Energia.csv".
    El ExaJulio es una unidad diferentes al TWh, es decir, no tiene sentido sumarlos o
    buscar proporciones entre ellos, la fórmula de conversión es:
    277.778 Teravatios/Hora (TWh) = 1 Exajulio
    Los campos terminados en "_EJ" corresponden a mediciones en Exajulios,
    y los terminados en "_TWh" corresponden a Teravatios/Hora.
    La consigna es crear un nuevo campo, que se denomine "Consumo_Total"
    y que guarde la sumatoria de todos los consumos expresados en Teravatios/Hora
    (convirtiendo a esta medida los que están en Exajulios)
    Esta función debe informar el consumo total para la entidad 'World' y año '2019',
    redondeado a 2 decimales, retornando ese valor en un dato de tipo float.
    '''
    #Tu código aca:
    df = pd.read_csv("./datasets/Fuentes_Consumo_Energia.csv")

    df['Consumo_Total'] = (df.Coal_Consumption_EJ*277.778 + 
                          df.Gas_Consumption_EJ*277.778 +
                          df.Geo_Biomass_Other_TWh +
                          df.Hydro_Generation_TWh +
                          df.Nuclear_Generation_TWh +
                          df.Solar_Generation_TWh +
                          df.Wind_Generation_TWh +
                          df.Oil_Consumption_EJ*277.778)

    return round(float(df[(df.Entity == 'World') & (df.Year == 2019)]['Consumo_Total'].values),2)

def Ret_Pregunta05():
    '''
    Debes utilizar Pandas para ingestar en un objeto Dataframe el contenido del archivo provisto
    "Fuentes_Consumo_Energia.csv".
    Esta función debe informar el año de mayor generación de energía hídrica (Hydro_Generation_TWh)
    para la entidad 'Europe' retornando ese valor en un dato de tipo entero.
    '''
    #Tu código aca:
    df = pd.read_csv("./datasets/Fuentes_Consumo_Energia.csv")

    mask = df["Entity"] == "Europe"

    df = df[mask]

    indice = df.Hydro_Generation_TWh.idxmax() 

    return df.Year[indice]

def Ret_Pregunta06(m1, m2, m3):
    '''
    Esta función recibe tres array de Numpy de 2 dimensiones cada uno, y devuelve el valor booleano
    True si es posible realizar una multiplicación entre las tres matrices (n1 x n2 x n3),
    y el valor booleano False si no lo es
    Ej:
        n1 = np.array([[0,0,0],[1,1,1],[2,2,2]])
        n2 = np.array([[3,3],[4,4],[5,5]])
        n3 = np.array([1,1],[2,2])
        print(Ret_Pregunta06(n1,n2,n3))
            True            -> Valor devuelto por la función en este ejemplo
        print(Ret_Pregunta06(n2,n1,n3))
            False            -> Valor devuelto por la función en este ejemplo
    '''
    #Tu código aca:

    if (m1.shape[1] == m2.shape[0]):
        if (np.dot(m1,m2).shape[1]== m3.shape[0]):
            return True

    return False
    
def Ret_Pregunta07():
    '''
    Debes utilizar Pandas para ingestar en un objeto Dataframe el contenido del archivo provisto
    "Fuentes_Consumo_Energia.csv".
    Esta función debe informar cuál de la siguiente lista de países tuvo mayor generacíon de
    energía hìdrica (Hydro_Generation_TWh) en el año 2019:
        * Argentina
        * Brazil
        * Chile
        * Colombia
        * Ecuador
        * Mexico
        * Peru
    Debe retornar el valor en un dato de tipo string.
    '''
    #Tu código aca:
    df = pd.read_csv("./datasets/Fuentes_Consumo_Energia.csv")

    pais = ["Argentina","Brazil","Chile","Colombia","Ecuador","Mexico","Peru"]

    mask = (df["Entity"].isin(pais)) & (df["Year"] == 2019)
    df = df[mask]

    indice = df.Hydro_Generation_TWh.idxmax()


    return  df["Entity"][indice]

def Ret_Pregunta08():
    '''
    Debes utilizar Pandas para ingestar en un objeto Dataframe el contenido del archivo provisto
    "Fuentes_Consumo_Energia.csv".
    Esta función debe informar la cantidad de entidades diferentes que están presentes en el dataset
    retornando ese valor en un dato de tipo entero.
    '''
    #Tu código aca:
    df = pd.read_csv("./datasets/Fuentes_Consumo_Energia.csv")

    return df["Entity"].nunique()

def Ret_Pregunta09():
    '''
    Debes utilizar Pandas para ingestar en un objeto Dataframe el contenido del archivo provisto
    "datasets/Tabla1_ejercicio.csv" y "datasets/Tabla2_ejercicio.csv".
    Esta función debe informar: score_promedio_femenino y score_promedio_masculino en formato tupla
    '''
    #Tu código aca:
    
    df_ejercicio1 = pd.read_csv("./datasets/Tabla1_ejercicio.csv", sep=';')
    df_ejercicio2 = pd.read_csv('./datasets/Tabla2_ejercicio.csv', sep=';')
    df_final = pd.merge(df_ejercicio1,df_ejercicio2,on="pers_id").drop_duplicates()
    
    score_promedio_femenino = round(df_final[df_final.sexo=="F"].score.mean(),2)
    score_promedio_masculino = round(df_final[df_final.sexo=="M"].score.mean(),2)
    tupla_final = (score_promedio_femenino, score_promedio_masculino)
    return tupla_final

def Ret_Pregunta10(lista):
    '''
    Esta función recibe como parámetro un objeto de la clase Lista() definida en el archivo Lista.py.
    Debe recorrer la lista y retornan la cantidad de nodos que posee. Utilizar el método de la clase
    Lista llamado getCabecera()
    Ejemplo:
        lis = Lista()
        lista.agregarElemento(1)
        lista.agregarElemento(2)
        lista.agregarElemento(3)
        print(Ret_Pregunta10(lista))
            3    -> Debe ser el valor devuelto por la función Ret_Pregunta10() en este ejemplo
    '''
    #Tu código aca:
    nodos=0

    elemento = lista.getCabecera()

    if elemento != None:
        nodos = 1
    else:
        return 0

    while elemento.getSiguiente() != None:
        elemento = elemento.getSiguiente()
        nodos += 1
    
    return nodos
