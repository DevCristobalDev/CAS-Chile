USE [Bodega]
GO
/****** Object:  Table [dbo].[Articulo]    Script Date: 13/02/2024 14:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Articulo](
	[Codigo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NOT NULL,
	[FechaIngreso] [datetime] NOT NULL,
	[Valor] [numeric](18, 2) NOT NULL,
	[StockMinimo] [numeric](18, 0) NOT NULL,
	[CodigoBodega] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Articulo] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bodega]    Script Date: 13/02/2024 14:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bodega](
	[CodigoBodega] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Bodega] PRIMARY KEY CLUSTERED 
(
	[CodigoBodega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Articulo]  WITH CHECK ADD  CONSTRAINT [FK_Articulo_Bodega] FOREIGN KEY([CodigoBodega])
REFERENCES [dbo].[Bodega] ([CodigoBodega])
GO
ALTER TABLE [dbo].[Articulo] CHECK CONSTRAINT [FK_Articulo_Bodega]
GO
/****** Object:  StoredProcedure [dbo].[SP_EditarArticulo]    Script Date: 13/02/2024 14:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Cristobal
-- Create date: 12-02-2024
-- Description:	Actualiza el articulo segun los valores enviados por el usuario
-- =============================================
create PROCEDURE [dbo].[SP_EditarArticulo] 
	@descripcion	varchar(30)
	,@fechaIngreso	datetime
	,@valor			numeric(18,2)
	,@stockMinimo	numeric(18,0)
	,@codigoBodega	numeric(18,0)
	,@codigo		numeric(18,0)
AS
BEGIN
	
	update	Articulo
	set		Descripcion		= @descripcion
			,FechaIngreso	= @fechaIngreso
			,Valor			= @valor
			,StockMinimo	= @stockMinimo
			,CodigoBodega	= @codigoBodega
	where	Codigo			= @codigo
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EliminarArticulo]    Script Date: 13/02/2024 14:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Cristobal
-- Create date: 12-02-2024
-- Description:	Elimina el articulo seleccionado por el usuario
-- =============================================
CREATE PROCEDURE [dbo].[SP_EliminarArticulo] 
		@codigo		numeric(18,0)
AS
BEGIN
	
	delete 
	from	Articulo
	where	Codigo	= @codigo

END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertaArticulo]    Script Date: 13/02/2024 14:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Cristobal
-- Create date: 12/02/2024
-- Description:	Inserta un nuevo articulo
-- =============================================
CREATE PROCEDURE [dbo].[SP_InsertaArticulo] 
	@descripcion	varchar(30)
	,@fechaIngreso	datetime
	,@valor			numeric(18,2)
	,@stockMinimo	numeric(18,0)
	,@codigoBodega	numeric(18,0)
AS
BEGIN
	
	insert into Articulo (Descripcion, FechaIngreso , Valor,  StockMinimo,  CodigoBodega) 
				values(  @descripcion, @fechaIngreso, @valor, @stockMinimo, @codigoBodega)


END
GO
/****** Object:  StoredProcedure [dbo].[SP_ListaArticulos]    Script Date: 13/02/2024 14:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Cristobal
-- Create date: 12-02-2024
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ListaArticulos] 

AS
BEGIN
	select		a.Codigo
				,a.Descripcion
				,a.FechaIngreso
				,a.Valor
				,a.StockMinimo
				,b.Descripcion	Bodega
	from		Articulo	a
	inner join	Bodega		b on a.CodigoBodega = b.CodigoBodega
	order by	a.Codigo asc
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ObtieneDatosBodega]    Script Date: 13/02/2024 14:18:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Cristobal
-- Create date: 12/02/2024
-- Description: trae los datos para llenar el comboBox bodega
-- =============================================
CREATE PROCEDURE [dbo].[SP_ObtieneDatosBodega] 
	
AS
BEGIN
	select  -1					CodigoBodega
			,'-- Seleccione --'	Descripcion
	union
	select	CodigoBodega
			,Descripcion
	from	Bodega
END
GO


--  Insert

select * from Bodega

insert into Bodega (Descripcion) values ('Sucursal Santiago')
insert into Bodega (Descripcion) values ('Sucursal Norte')
insert into Bodega (Descripcion) values ('Sucursal Sur')
insert into Bodega (Descripcion) values ('Sucursal Viña del mar')