
drop table viajero cascade constraints;
CREATE TABLE viajero(
	numId varchar(10) NOT NULL,
	tipoId varchar(1) NOT NULL,
	fechaExpId date NOT NULL,
	apellido1 varchar(20) NOT NULL,
	apellido2 varchar(20) NOT NULL,
	nombre varchar(20) NOT NULL,
	sexo varchar(1) ,
	fechaNacimiento date NOT NULL,
	paisNacionalidad varchar(30) NOT NULL,
	constraint tipo_id check(tipoId IN('D','P','C','I','N','X')),
	constraint viaj_sexo CHECK(sexo IN('M','F')),
	constraint pk_viajero PRIMARY KEY (numId)
);
drop table encargado cascade constraints;
CREATE TABLE encargado(
	NSS varchar(10) NOT NULL,
	nombre varchar(20) NOT NULL,
	apellido1 varchar(20) NOT NULL,
	apellido2 varchar(20) NOT NULL,
	constraint pk_encargado PRIMARY KEY (NSS)
);

drop table libroRegistro cascade constraints;
CREATE TABLE libroRegistro(
	idLibro varchar(9) NOT NULL,
	numPaginas varchar(3) NOT NULL, 
	constraint numpag_maxlibro check (numPaginas<500),
	constraint numpag_minlibro check (100<numPaginas),
	constraint pk_libro PRIMARY KEY (idLibro)
);
drop table parteEntrada cascade constraints;
CREATE TABLE parteEntrada(
	numID varchar(10) NOT NULL,
	firma varchar(10) NOT NULL,
	fechaEntrada date NOT NULL,
	fechaSalida date,
	idLibro varchar(9),
	constraint fk1_parte FOREIGN KEY(idLibro) REFERENCES libroRegistro(idLibro),
	constraint fk2_parte FOREIGN KEY (numID) REFERENCES viajero(numId),
	constraint pk_parte PRIMARY KEY (numID, fechaEntrada)
);

drop table registrar cascade constraints;
CREATE TABLE registrar(
	NSS varchar(10) NOT NULL,
	fechaEntrada date NOT NULL,
	numId varchar(10) NOT NULL,
	constraint fk1_registrar FOREIGN KEY (NSS) REFERENCES encargado(NSS),
	constraint fk2_registrar FOREIGN KEY (numID , fechaEntrada) REFERENCES parteEntrada(numID,fechaEntrada),
	constraint pk_registrar PRIMARY KEY (NSS,fechaEntrada,numID)
);

	
