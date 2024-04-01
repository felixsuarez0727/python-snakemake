# Importar librerías necesarias
import pandas as pd

# Regla para crear un archivo de texto 'hello.txt' con el contenido 'hello world'
rule hello:
    output:
        # Archivo de salida nombrado como '{prefix}.txt', donde '{prefix}' es un marcador de posición
        '{prefix}.txt'
        # Comando shell para escribir 'hello world' en el archivo de salida
    shell:
        'echo hello world > {output}'

# Regla para crear un archivo CSV con contenido de 'hello.txt'
rule world:
    input:
        # Archivo de entrada nombrado como '{prefix}.txt', donde '{prefix}' es un marcador de posición
        '{prefix}.txt'
    output:
        # Archivo de salida nombrado como '{prefix}.second.csv', donde '{prefix}' es un marcador de posición
        '{prefix}.second.csv'
    shell:
        '''
        cat {input} > {output}
        echo This is the second line >> {output}
        '''

# Regla para procesar 'hello.txt' y crear un archivo TSV 'hello.bello.tsv' usando pandas
rule bello:
    input:
        # Nombre de archivo de entrada especificado explícitamente como 'hello.txt'
        'hello.txt'
    output:
        # Nombre de archivo de salida especificado explícitamente como 'hello.bello.tsv'
        'hello.bello.tsv'
    run:
        # Leer el contenido de 'hello.txt' en un DataFrame de pandas
        data = pd.read_csv('hello.txt', header=None)
        # Modificar el valor en la primera fila y primera columna del DataFrame
        data.iloc[0, 0] = 1
        # Escribir el DataFrame modificado en un archivo TSV 'hello.bello.tsv'
        data.to_csv('hello.bello.tsv', sep='\t', index=False)

# Regla para ejecutar el script de R
rule r_script:
    input:
        # Archivo de entrada para el script de R
        'hello.txt'
    output:
        # Archivo de salida del script de R
        'output_from_R.txt'
    shell:
        # Comando para ejecutar el script de R
        'Rscript script.R {input} {output}'

# Regla para especificar los archivos de salida finales deseados
rule all:
    input:
        # Todos los archivos de salida de las reglas anteriores
        "hello.second.csv",
        "hello.bello.tsv",
        "output_from_R.txt"
