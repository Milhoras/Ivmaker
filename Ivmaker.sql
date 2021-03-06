IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'ivmaker')
	DROP DATABASE [ivmaker]
GO

CREATE DATABASE [ivmaker]  ON (NAME = N'ivmaker_dat', FILENAME = N'E:\mssql\MSSQL\Data\ivmaker.mdf' , SIZE = 2666, FILEGROWTH = 10%) LOG ON (NAME = N'ivmaker_log', FILENAME = N'E:\mssql\MSSQL\Data\ivmaker.ldf' , SIZE = 459, FILEGROWTH = 10%)
 COLLATE SQL_Latin1_General_CP850_CI_AI
GO

exec sp_dboption N'ivmaker', N'autoclose', N'false'
GO

exec sp_dboption N'ivmaker', N'bulkcopy', N'false'
GO

exec sp_dboption N'ivmaker', N'trunc. log', N'true'
GO

exec sp_dboption N'ivmaker', N'torn page detection', N'true'
GO

exec sp_dboption N'ivmaker', N'read only', N'false'
GO

exec sp_dboption N'ivmaker', N'dbo use', N'false'
GO

exec sp_dboption N'ivmaker', N'single', N'false'
GO

exec sp_dboption N'ivmaker', N'autoshrink', N'false'
GO

exec sp_dboption N'ivmaker', N'ANSI null default', N'false'
GO

exec sp_dboption N'ivmaker', N'recursive triggers', N'false'
GO

exec sp_dboption N'ivmaker', N'ANSI nulls', N'false'
GO

exec sp_dboption N'ivmaker', N'concat null yields null', N'false'
GO

exec sp_dboption N'ivmaker', N'cursor close on commit', N'false'
GO

exec sp_dboption N'ivmaker', N'default to local cursor', N'false'
GO

exec sp_dboption N'ivmaker', N'quoted identifier', N'false'
GO

exec sp_dboption N'ivmaker', N'ANSI warnings', N'false'
GO

exec sp_dboption N'ivmaker', N'auto create statistics', N'true'
GO

exec sp_dboption N'ivmaker', N'auto update statistics', N'true'
GO

use [ivmaker]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Publicacion_Auspicio]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Publicacion] DROP CONSTRAINT FK_Publicacion_Auspicio
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_CuerpoFolio_Cuerpo]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[CuerpoFolio] DROP CONSTRAINT FK_CuerpoFolio_Cuerpo
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__NotasDein__cod_d__0F2D40CE]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[NotasDeinteres] DROP CONSTRAINT FK__NotasDein__cod_d__0F2D40CE
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__LogEncues__cod_e__0880433F]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[LogEncuesta] DROP CONSTRAINT FK__LogEncues__cod_e__0880433F
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__OpcionEnc__cod_e__12FDD1B2]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[OpcionEncuesta] DROP CONSTRAINT FK__OpcionEnc__cod_e__12FDD1B2
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_CuerpoFolio_Folios]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[CuerpoFolio] DROP CONSTRAINT FK_CuerpoFolio_Folios
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ForoOpinion_Foro]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ForoOpinion] DROP CONSTRAINT FK_ForoOpinion_Foro
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__FotoNota__cod_fo__0697FACD]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[FotoNota] DROP CONSTRAINT FK__FotoNota__cod_fo__0697FACD
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__FotoNota1__cod_fo__0697FACD]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[FotoNota1] DROP CONSTRAINT FK__FotoNota1__cod_fo__0697FACD
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ConstantesModulo_Modulo]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ConstantesModulo] DROP CONSTRAINT FK_ConstantesModulo_Modulo
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__Plantilla__cod_m__19AACF41]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[PlantillasModulo] DROP CONSTRAINT FK__Plantilla__cod_m__19AACF41
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__Publicaci__cod_m__1C873BEC]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[PublicacionModulo] DROP CONSTRAINT FK__Publicaci__cod_m__1C873BEC
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__NotaAddNe__cod_n__0B5CAFEA]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[NotaAddNewsletter] DROP CONSTRAINT FK__NotaAddNe__cod_n__0B5CAFEA
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__NotaNewsL__cod_n__0C50D423]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[NotaNewsLetter] DROP CONSTRAINT FK__NotaNewsL__cod_n__0C50D423
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__NotaNewsL__cod_n__0D44F85C]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[NotaNewsLetter] DROP CONSTRAINT FK__NotaNewsL__cod_n__0D44F85C
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__NotaNewsL__cod_n__0E391C95]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[NotaNewsLetter] DROP CONSTRAINT FK__NotaNewsL__cod_n__0E391C95
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__Votacion__cod_no__29E1370A]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Votacion] DROP CONSTRAINT FK__Votacion__cod_no__29E1370A
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__LogEncues__cod_o__09746778]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[LogEncuesta] DROP CONSTRAINT FK__LogEncues__cod_o__09746778
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__PizarraAn__cod_p__17C286CF]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[PizarraAnuncio] DROP CONSTRAINT FK__PizarraAn__cod_p__17C286CF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__VideoSecc__cod_p__2704CA5F]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[VideoSeccion] DROP CONSTRAINT FK__VideoSecc__cod_p__2704CA5F
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__Pizarra__cod_pla__16CE6296]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Pizarra] DROP CONSTRAINT FK__Pizarra__cod_pla__16CE6296
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__Recomenda__cod_p__1E6F845E]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Recomendamos] DROP CONSTRAINT FK__Recomenda__cod_p__1E6F845E
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__VotacionO__cod_p__2BC97F7C]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[VotacionOpinion] DROP CONSTRAINT FK__VotacionO__cod_p__2BC97F7C
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__VotacionP__cod_p__2EA5EC27]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[VotacionPuntaje] DROP CONSTRAINT FK__VotacionP__cod_p__2EA5EC27
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Plantillas_Publicacion1]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Plantillas] DROP CONSTRAINT FK_Plantillas_Publicacion1
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_PublicacionModulo_Publicacion]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[PublicacionModulo] DROP CONSTRAINT FK_PublicacionModulo_Publicacion
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_UsuarioPerfil_Publicacion]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[UsuarioPerfil] DROP CONSTRAINT FK_UsuarioPerfil_Publicacion
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__NotasReco__cod_r__48BAC3E5]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[NotasRecomendamos] DROP CONSTRAINT FK__NotasReco__cod_r__48BAC3E5
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Publicacion_Servidores]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Publicacion] DROP CONSTRAINT FK_Publicacion_Servidores
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_TamanioFotoPublicacion_TamanioFoto]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[TamanioFotoPublicacion] DROP CONSTRAINT FK_TamanioFotoPublicacion_TamanioFoto
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_Funciones_TemaFuncion]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[Funciones] DROP CONSTRAINT FK_Funciones_TemaFuncion
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_UsuarioPerfil_Usuario]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[UsuarioPerfil] DROP CONSTRAINT FK_UsuarioPerfil_Usuario
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__VotacionO__cod_v__2CBDA3B5]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[VotacionOpinion] DROP CONSTRAINT FK__VotacionO__cod_v__2CBDA3B5
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK__VotacionP__cod_v__2DB1C7EE]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[VotacionPuntaje] DROP CONSTRAINT FK__VotacionP__cod_v__2DB1C7EE
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[trgAdicionaNota]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[trgAdicionaNota]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[trgEliminaNota]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[trgEliminaNota]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[trg_Archiva]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[trg_Archiva]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LimpiaDesPagina_pdf]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[LimpiaDesPagina_pdf]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[trgEliminaPublicacion]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[trgEliminaPublicacion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[trgEliminaSeccion]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[trgEliminaSeccion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TR_ACTUALIZA_TEXTO]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[TR_ACTUALIZA_TEXTO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LimpiaHTML]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[LimpiaHTML]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LimpiaTituloHTML]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[LimpiaTituloHTML]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ECW_IVMK_SP_ACTUALIZARNOTAS_TEMP]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ECW_IVMK_SP_ACTUALIZARNOTAS_TEMP]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ECW_IVMK_SP_SEL_NOTASIMPRESA_TEMP]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ECW_IVMK_SP_SEL_NOTASIMPRESA_TEMP]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ECW_IVMK_SP_SEL_SUPLEMENTO_TEMP]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ECW_IVMK_SP_SEL_SUPLEMENTO_TEMP]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ECW_SP_PORTADA_EDIMPRESA_SEL]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[ECW_SP_PORTADA_EDIMPRESA_SEL]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GrabaNotaPDF]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GrabaNotaPDF]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GrabaNota_old]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[GrabaNota_old]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[IAR_sp_CodSeccionPorAlias]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[IAR_sp_CodSeccionPorAlias]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[IAR_sp_P21ListColumnasAnt]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[IAR_sp_P21ListColumnasAnt]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[IAR_sp_P21ListDirector]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[IAR_sp_P21ListDirector]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[grabanota]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[grabanota]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[grabanota1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[grabanota1]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[grabanota_05092007]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[grabanota_05092007]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[grabanota_29052005]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[grabanota_29052005]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spCo_ApruebaNotaComentario]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spCo_ApruebaNotaComentario]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spCo_ConsultaNotaComentario]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spCo_ConsultaNotaComentario]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spCo_EliminaNotaComentario]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spCo_EliminaNotaComentario]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spCo_InsertaNotaComentario]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spCo_InsertaNotaComentario]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spCo_ListadoNotaComentario]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spCo_ListadoNotaComentario]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spCo_ListadoNotaComentarioTop]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spCo_ListadoNotaComentarioTop]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spCo_ModificaNotaComentario]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spCo_ModificaNotaComentario]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spGe_NotasConsultarXml]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spGe_NotasConsultarXml]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spGe_NotasFotoConsultarXml]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spGe_NotasFotoConsultarXml]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ActualizaCuerpo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ActualizaCuerpo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ActualizaCuerpoFolio]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ActualizaCuerpoFolio]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ActualizaEstadoArchivoNotas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ActualizaEstadoArchivoNotas]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ActualizaEstadoGeneracion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ActualizaEstadoGeneracion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ActualizaFolio]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ActualizaFolio]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ActualizaSuplemento]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ActualizaSuplemento]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_EliminaArchivosXAsignar]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_EliminaArchivosXAsignar]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_EliminaCuerpoFolio]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_EliminaCuerpoFolio]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_EliminaPaginasErradas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_EliminaPaginasErradas]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_EliminarRegistrosArchivosXAsignar]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_EliminarRegistrosArchivosXAsignar]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ExisteCuerpoFolio]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ExisteCuerpoFolio]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GeneraIndices]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GeneraIndices]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GeneraIndices1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GeneraIndices1]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GenerarEdicionImpresaXML]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GenerarEdicionImpresaXML]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ImportarEdicionImpresaXML]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ImportarEdicionImpresaXML]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_IngresaArchivosXAsignar]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_IngresaArchivosXAsignar]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_IngresaCuerpo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_IngresaCuerpo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_IngresaCuerpoFolio]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_IngresaCuerpoFolio]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_IngresaFolio]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_IngresaFolio]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_IngresaPaginasErradas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_IngresaPaginasErradas]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_IngresaTemporales_Online]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_IngresaTemporales_Online]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaArchivosXAsignar]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaArchivosXAsignar]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaCuerpo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaCuerpo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaCuerpoFolio]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaCuerpoFolio]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaDetalleNota]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaDetalleNota]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaFolio]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaFolio]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaNotasXPaginaySeccion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaNotasXPaginaySeccion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaNotasXPaginaySeccion_movil]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaNotasXPaginaySeccion_movil]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaNotasXPaginaySeccion_rtc]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaNotasXPaginaySeccion_rtc]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaNotasXSeccion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaNotasXSeccion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaPaginasErradas]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaPaginasErradas]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaPaginasPublicacion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaPaginasPublicacion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaPaginasSeccionSuplemento]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaPaginasSeccionSuplemento]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaPaginasSuplemento]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaPaginasSuplemento]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaPaginasSuplemento_OnLine]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaPaginasSuplemento_OnLine]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaSecciones]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaSecciones]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ListaUsuarioTemperatura]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ListaUsuarioTemperatura]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SacaUltimoContracorriente]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SacaUltimoContracorriente]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SeguimientoEdicionImpresa]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SeguimientoEdicionImpresa]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SelccionaNombreSeccion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SelccionaNombreSeccion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SeleccionaEditor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SeleccionaEditor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SeleccionaSeccion]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SeleccionaSeccion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_TraeNombrePagina]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_TraeNombrePagina]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_fec_formato]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_fec_formato]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_hor_formato]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_hor_formato]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchivosXAsignar]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchivosXAsignar]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Auspicio]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Auspicio]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ConstantesModulo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ConstantesModulo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Cuerpo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Cuerpo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CuerpoFolio]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CuerpoFolio]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Deinteres]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Deinteres]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Encuesta]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Encuesta]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Excepcion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Excepcion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Folio]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Folio]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Folio_bk]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Folio_bk]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Folios]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Folios]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Foro]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Foro]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ForoOpinion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ForoOpinion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Foto]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Foto]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Foto1]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Foto1]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FotoNota]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FotoNota]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FotoNota1]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FotoNota1]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Funciones]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Funciones]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LogEncuesta]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LogEncuesta]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Modulo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Modulo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NOTAS_TEMP]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NOTAS_TEMP]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NewsLetter]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NewsLetter]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NombresPdf]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NombresPdf]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NotaAddNewsletter]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NotaAddNewsletter]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NotaComenta]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NotaComenta]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NotaNewsLetter]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NotaNewsLetter]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Notas]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Notas]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Notas1]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Notas1]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NotasDeinteres]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NotasDeinteres]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NotasP21]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NotasP21]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NotasRecomendamos]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NotasRecomendamos]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NotasRelacionadas]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NotasRelacionadas]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OpcionEncuesta]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OpcionEncuesta]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PaginasErradas]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PaginasErradas]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PerfilFuncion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PerfilFuncion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Pizarra]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Pizarra]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PizarraAnuncio]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PizarraAnuncio]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Plantillas]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Plantillas]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PlantillasModulo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PlantillasModulo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Publicacion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Publicacion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PublicacionModulo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PublicacionModulo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Recomendamos]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Recomendamos]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Results]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Results]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Seccion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Seccion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Servidores]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Servidores]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Suplemento]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Suplemento]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Suplemento_Dia]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Suplemento_Dia]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Suplemento_OnLine]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Suplemento_OnLine]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tag]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Tag]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TagIvmaker]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TagIvmaker]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TamanioFoto]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TamanioFoto]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TamanioFotoPublicacion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TamanioFotoPublicacion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TemaFuncion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TemaFuncion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TemaVideo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TemaVideo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TempImpresa]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TempImpresa]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Transferencia]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Transferencia]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Ultima]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Ultima]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Usuario]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Usuario]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UsuarioPerfil]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[UsuarioPerfil]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Video]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Video]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VideoNota]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[VideoNota]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VideoSeccion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[VideoSeccion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Votacion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Votacion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VotacionOpinion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[VotacionOpinion]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VotacionPuntaje]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[VotacionPuntaje]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[estadisticas]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[estadisticas]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[filtro]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[filtro]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[forotema]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[forotema]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[log_gda]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[log_gda]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[notasGDA]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[notasGDA]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[notas_pdf]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[notas_pdf]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tempEditorial]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tempEditorial]
GO

CREATE TABLE [dbo].[ArchivosXAsignar] (
	[ID_ArchivoXAsignar] [int] NOT NULL ,
	[NombreArchivo] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Estado] [bit] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Auspicio] (
	[cod_auspicio] [smallint] IDENTITY (1, 1) NOT NULL ,
	[nom_auspicio] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_auspicio] [text] COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_auspiciotexto] [text] COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_auspiciofoto] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_urlauspicio] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[ConstantesModulo] (
	[cod_registro] [int] NOT NULL ,
	[cod_modulo] [smallint] NULL ,
	[nom_tabla] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[nom_campo] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[val_campo] [char] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Cuerpo] (
	[ID_Cuerpo] [int] IDENTITY (1, 1) NOT NULL ,
	[Cod_Cuerpo] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Cod_Estado] [bit] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[CuerpoFolio] (
	[ID_CuerpoFolio] [numeric](18, 0) NOT NULL ,
	[ID_Cuerpo] [int] NOT NULL ,
	[ID_Folio] [int] NOT NULL ,
	[ID_Seccion] [smallint] NOT NULL ,
	[Fec_Inicio] [int] NULL ,
	[Hora] [varchar] (8) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Deinteres] (
	[cod_deinteres] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_seccion] [int] NOT NULL ,
	[nom_deinteres] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_notamax] [smallint] NULL ,
	[nom_plantilla] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_rutasalida] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_generado] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Encuesta] (
	[cod_encuesta] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_publicacion] [int] NOT NULL ,
	[nom_encuesta] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_tituloencuesta] [char] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_preguntaEncuesta] [char] (250) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Excepcion] (
	[cod_excepcion] [char] (4) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[cod_seccion] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Folio] (
	[codigo] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_folio] [char] (4) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[nom_folio] [char] (20) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[cod_seccion] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Folio_bk] (
	[cod_folio] [char] (4) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[nom_folio] [char] (20) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[cod_seccion] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Folios] (
	[ID_Folio] [int] IDENTITY (1, 1) NOT NULL ,
	[Cod_Folio] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Nom_Folio] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Fecha] [int] NULL ,
	[Hora] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Foro] (
	[cod_foro] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_publicacion] [smallint] NULL ,
	[cod_auspicio] [smallint] NULL ,
	[cod_nota] [int] NULL ,
	[des_tituloforo] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_sumillaforo] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[tip_foro] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ForoOpinion] (
	[cod_opinion] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_foro] [int] NULL ,
	[cod_padre] [int] NULL ,
	[cod_principal] [int] NULL ,
	[num_nivel] [tinyint] NULL ,
	[des_asunto] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_opinion] [char] (1000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_email] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_nombre] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_direccionIp] [char] (15) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Foto] (
	[cod_foto] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_publicacion] [smallint] NOT NULL ,
	[des_nombrearchivo] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_autor] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Foto1] (
	[cod_foto] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_publicacion] [smallint] NOT NULL ,
	[des_nombrearchivo] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_autor] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NOT NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[FotoNota] (
	[cod_registro] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_nota] [int] NOT NULL ,
	[cod_foto] [int] NOT NULL ,
	[des_sumillafoto] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_prioridad] [tinyint] NULL ,
	[fec_registro] [datetime] NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[FotoNota1] (
	[cod_registro] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_nota] [int] NOT NULL ,
	[cod_foto] [int] NOT NULL ,
	[des_sumillafoto] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_prioridad] [tinyint] NULL ,
	[fec_registro] [datetime] NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Funciones] (
	[cod_funcion] [smallint] IDENTITY (1, 1) NOT NULL ,
	[cod_tema] [tinyint] NULL ,
	[des_funcion] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_comando] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[tip_comando] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_defecto] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[LogEncuesta] (
	[cod_registro] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_encuesta] [int] NOT NULL ,
	[cod_opcion] [int] NOT NULL ,
	[des_direccionip] [char] (18) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Modulo] (
	[cod_modulo] [smallint] IDENTITY (1, 1) NOT NULL ,
	[nom_modulo] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_modulo] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_Comando1] [char] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_Comando2] [char] (250) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[nom_directorio] [char] (20) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[NOTAS_TEMP] (
	[cod_nota] [int] NOT NULL ,
	[cod_publicacion] [smallint] NULL ,
	[cod_usuario] [smallint] NULL ,
	[cod_seccion] [smallint] NOT NULL ,
	[cod_auspicio] [smallint] NULL ,
	[cod_plantilla] [smallint] NULL ,
	[des_tituloNota] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_cabecera] [char] (2000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_volada] [char] (2000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_texto] [text] COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_autor] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_textoauxiliar] [char] (200) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_nombrepagina] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_prioridad] [smallint] NULL ,
	[num_prioridadportada] [smallint] NULL ,
	[est_generado] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_portada] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_fotoaleatoria] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_archivo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[des_pagina] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_Transaccion] [datetime] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[NewsLetter] (
	[cod_newsletter] [int] NOT NULL ,
	[cod_auspicio] [int] NULL ,
	[nom_newsletter] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[des_archivotexto] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_archivohtml] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_vecesgenerado] [smallint] NULL ,
	[des_rutasalida] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_Activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_generacion] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_ultGeneracion] [datetime] NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[NombresPdf] (
	[seccion] [char] (2) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[NumPage] [int] NULL ,
	[NomPage] [char] (15) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[dia] [char] (2) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[Mes] [char] (2) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[anio] [char] (2) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[NotaAddNewsletter] (
	[cod_nota] [int] NOT NULL ,
	[cod_newsletter] [int] NULL ,
	[des_titulo] [char] (250) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_cabecera] [char] (1000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_enlace] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_foto] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_urlenlace] [char] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[NotaComenta] (
	[id_NotaComenta] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_Nota] [int] NULL ,
	[id_TipEdi] [tinyint] NULL ,
	[vTitulo] [varchar] (25) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[vComentario] [varchar] (2000) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[vAutor] [varchar] (60) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[vEmail] [varchar] (45) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[bEstNot] [bit] NULL ,
	[bEstApr] [bit] NULL ,
	[sdFecCre] [smalldatetime] NULL ,
	[cUsuMod] [char] (15) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[sdFecMod] [smalldatetime] NULL ,
	[cUsuEli] [char] (15) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[sdFecEli] [smalldatetime] NULL ,
	[vHost] [varchar] (25) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[NotaNewsLetter] (
	[cod_registro] [int] NOT NULL ,
	[cod_nota] [int] NULL ,
	[cod_newsletter] [int] NULL ,
	[num_prioridad] [smallint] NULL ,
	[tip_nota] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Notas] (
	[cod_nota] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_publicacion] [smallint] NULL ,
	[cod_usuario] [smallint] NULL ,
	[cod_seccion] [smallint] NOT NULL ,
	[cod_auspicio] [smallint] NULL ,
	[cod_plantilla] [smallint] NULL ,
	[des_tituloNota] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_cabecera] [char] (2000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_volada] [char] (2000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_texto] [text] COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_autor] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_textoauxiliar] [char] (200) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_nombrepagina] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_prioridad] [smallint] NULL ,
	[num_prioridadportada] [smallint] NULL ,
	[est_generado] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_portada] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_fotoaleatoria] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_archivo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[des_pagina] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Notas1] (
	[cod_nota] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_publicacion] [smallint] NULL ,
	[cod_usuario] [smallint] NULL ,
	[cod_seccion] [smallint] NOT NULL ,
	[cod_auspicio] [smallint] NULL ,
	[cod_plantilla] [smallint] NULL ,
	[des_tituloNota] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_cabecera] [char] (2000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_volada] [char] (2000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_texto] [text] COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_autor] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_textoauxiliar] [char] (200) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_nombrepagina] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_prioridad] [smallint] NULL ,
	[num_prioridadportada] [smallint] NULL ,
	[est_generado] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_portada] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_fotoaleatoria] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_archivo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[des_pagina] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[NotasDeinteres] (
	[cod_notaDeI] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_deinteres] [int] NOT NULL ,
	[des_titulo] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[des_enlace] [char] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[est_activo] [char] (18) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [char] (18) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[NotasP21] (
	[cod_nota] [int] NOT NULL ,
	[cod_publicacion] [smallint] NULL ,
	[cod_usuario] [smallint] NULL ,
	[cod_seccion] [smallint] NOT NULL ,
	[cod_auspicio] [smallint] NULL ,
	[cod_plantilla] [smallint] NULL ,
	[des_tituloNota] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_cabecera] [char] (2000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_texto] [text] COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_autor] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_textoauxiliar] [char] (200) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_nombrepagina] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_prioridad] [smallint] NULL ,
	[num_prioridadportada] [smallint] NULL ,
	[est_generado] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_portada] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_fotoaleatoria] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_archivo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[NotasRecomendamos] (
	[cod_Notasrecomendamos] [int] NOT NULL ,
	[cod_recomendamos] [int] NOT NULL ,
	[cod_auspicio] [int] NULL ,
	[des_titulo] [char] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_subtitulo] [char] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_sumilla] [char] (350) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_foto] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_enlace] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[NotasRelacionadas] (
	[cod_relacionNota] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_nota] [int] NOT NULL ,
	[cod_notarelacionada] [int] NULL ,
	[num_prioridad] [tinyint] NULL ,
	[des_titulo] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_enlace] [char] (350) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[OpcionEncuesta] (
	[cod_opcion] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_encuesta] [int] NOT NULL ,
	[des_opcion] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_coloropcion] [char] (20) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_acumuladoopcion] [numeric](18, 0) NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[PaginasErradas] (
	[ID_Pagina] [int] NOT NULL ,
	[Des_pagina] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Fecha] [int] NULL ,
	[SeccionID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FechaRegistro] [int] NULL ,
	[HoraRegistro] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[PerfilFuncion] (
	[cod_registro] [smallint] IDENTITY (1, 1) NOT NULL ,
	[cod_funcion] [smallint] NOT NULL ,
	[cod_usuario] [smallint] NULL ,
	[cod_publicacion] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Pizarra] (
	[cod_pizarra] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_plantillamodulo] [smallint] NULL ,
	[cod_auspicio] [int] NULL ,
	[cod_publicacion] [int] NOT NULL ,
	[cod_seccion] [int] NOT NULL ,
	[nom_pizarra] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_pizarra] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_vigencia] [datetime] NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[PizarraAnuncio] (
	[cod_anuncio] [int] NOT NULL ,
	[cod_pizarra] [int] NULL ,
	[des_asunto] [char] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_anuncio] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_nombre] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_email] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_direccionIp] [char] (18) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Plantillas] (
	[cod_plantilla] [smallint] IDENTITY (1, 1) NOT NULL ,
	[nom_plantilla] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[cod_publicacion] [smallint] NOT NULL ,
	[tip_plantilla] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_archivoplantilla] [char] (25) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[PlantillasModulo] (
	[cod_plantillamodulo] [smallint] IDENTITY (1, 1) NOT NULL ,
	[cod_modulo] [smallint] NULL ,
	[nom_plantilla] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[nom_archivoplantilla] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Publicacion] (
	[cod_publicacion] [smallint] IDENTITY (1, 1) NOT NULL ,
	[cod_servidor] [tinyint] NOT NULL ,
	[nom_publicacion] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_publicacion] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_rutaFisica] [char] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_rutaFTP] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_rutaVirtual] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[nom_paginaprincipal] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[cod_auspicio] [smallint] NULL ,
	[est_Activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_replicacion] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[nom_paginaaspportada] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_generado] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[PublicacionModulo] (
	[cod_publicacion] [smallint] NOT NULL ,
	[cod_modulo] [smallint] NOT NULL ,
	[cod_plantillamodulo] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Recomendamos] (
	[cod_recomendamos] [int] NOT NULL ,
	[cod_publicacion] [int] NULL ,
	[cod_plantillamodulo] [smallint] NULL ,
	[nom_recomendamos] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_notasMax] [smallint] NULL ,
	[des_rutasalida] [char] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_generada] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Results] (
	[cod_nota] [int] NOT NULL ,
	[cod_publicacion] [smallint] NULL ,
	[cod_usuario] [smallint] NULL ,
	[cod_seccion] [smallint] NOT NULL ,
	[cod_auspicio] [smallint] NULL ,
	[cod_plantilla] [smallint] NULL ,
	[des_tituloNota] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_cabecera] [char] (2000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_texto] [text] COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_autor] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_textoauxiliar] [char] (200) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_nombrepagina] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_prioridad] [smallint] NULL ,
	[num_prioridadportada] [smallint] NULL ,
	[est_generado] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_portada] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_fotoaleatoria] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_archivo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[des_pagina] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Seccion] (
	[cod_seccion] [smallint] IDENTITY (1, 1) NOT NULL ,
	[cod_plantilla] [smallint] NOT NULL ,
	[cod_auspicio] [smallint] NULL ,
	[cod_publicacion] [smallint] NULL ,
	[nom_seccion] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_alias] [char] (20) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_plantillaASP] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[cod_plantilladefectonota] [smallint] NULL ,
	[est_generadoIndice] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Servidores] (
	[cod_servidor] [tinyint] IDENTITY (1, 1) NOT NULL ,
	[nom_servidor] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_usuario] [char] (20) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_clave] [char] (20) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_dominio] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_ipdireccion] [char] (20) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[nom_contactotecnico] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_telefonocontacto] [char] (20) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_emailcontacto] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_cadenaconexionbd] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Suplemento] (
	[Id_Suplemento] [int] NULL ,
	[nro_Dia] [smallint] NULL ,
	[des_Pagina] [varchar] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_Registro] [char] (10) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[ruta_pagina] [varchar] (400) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[prioridad] [smallint] NULL ,
	[seccion] [varchar] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_registro] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Suplemento_Dia] (
	[nro_Dia] [smallint] NOT NULL ,
	[cod_Seccion] [int] NULL ,
	[alias_Seccion] [varchar] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_prioridad] [smallint] NULL ,
	[fec_Transaccion] [datetime] NULL ,
	[est_Activo] [smallint] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Suplemento_OnLine] (
	[Id_Suplemento] [int] NULL ,
	[nro_Dia] [smallint] NULL ,
	[des_Pagina] [varchar] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_Registro] [char] (10) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[ruta_pagina] [varchar] (400) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[prioridad] [smallint] NULL ,
	[seccion] [varchar] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_registro] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Tag] (
	[cod_tag] [char] (40) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[tip_tag] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TagIvmaker] (
	[cod_tag] [int] IDENTITY (1, 1) NOT NULL ,
	[nom_tag] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[des_tag] [char] (200) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_baseDatos] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_tabla] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_campo] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_formato] [char] (250) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[Tip_tag] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TamanioFoto] (
	[cod_tamanio] [tinyint] IDENTITY (1, 1) NOT NULL ,
	[des_tamanio] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_creacion] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TamanioFotoPublicacion] (
	[cod_publicacion] [smallint] NOT NULL ,
	[cod_tamanio] [tinyint] NOT NULL ,
	[est_defecto] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_ampliable] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TemaFuncion] (
	[cod_tema] [tinyint] IDENTITY (1, 1) NOT NULL ,
	[nom_tema] [char] (20) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[Tip_tema] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TemaVideo] (
	[cod_tema] [int] IDENTITY (1, 1) NOT NULL ,
	[nom_tema] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TempImpresa] (
	[orden] [int] IDENTITY (1, 1) NOT NULL ,
	[NombrePDF] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[NombreJPG] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Transferencia] (
	[cod_Transferencia] [int] IDENTITY (1, 1) NOT NULL ,
	[Des_Comando] [text] COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NOT NULL ,
	[est_registro] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Ultima] (
	[cod_ultima] [char] (3) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[cod_seccion] [smallint] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Usuario] (
	[cod_usuario] [smallint] IDENTITY (1, 1) NOT NULL ,
	[nom_usuario] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_email] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_usuario] [char] (15) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_clave] [char] (15) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[tip_nivel] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[flg_ftp] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[UsuarioPerfil] (
	[cod_perfil] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_usuario] [smallint] NOT NULL ,
	[cod_publicacion] [smallint] NULL ,
	[cod_seccion] [smallint] NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Video] (
	[cod_video] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_tema] [int] NULL ,
	[des_titulo] [char] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_video] [char] (250) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_RutaAltaCalidad] [char] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_RutabajaCalidad] [char] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[flag] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[VideoNota] (
	[cod_registro] [int] IDENTITY (1, 1) NOT NULL ,
	[cod_video] [int] NOT NULL ,
	[cod_auspicio] [int] NULL ,
	[cod_seccion] [int] NOT NULL ,
	[cod_nota] [int] NOT NULL ,
	[des_titulo] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_cabecera] [char] (2000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_foto] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[msrepl_tran_version] [uniqueidentifier] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[VideoSeccion] (
	[cod_videoseccion] [char] (18) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[cod_auspicio] [int] NULL ,
	[cod_seccion] [int] NOT NULL ,
	[cod_plantilla] [smallint] NOT NULL ,
	[num_anchoventana] [smallint] NULL ,
	[num_altoventana] [smallint] NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Votacion] (
	[cod_votacion] [int] NOT NULL ,
	[cod_auspicio] [int] NULL ,
	[cod_nota] [int] NOT NULL ,
	[num_diasvigencia] [smallint] NULL ,
	[des_textoauxiliar] [char] (300) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[VotacionOpinion] (
	[cod_opinion] [int] NOT NULL ,
	[cod_plantillamodulo] [smallint] NULL ,
	[cod_votacion] [int] NULL ,
	[cod_puntaje] [char] (18) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_opinion] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[VotacionPuntaje] (
	[cod_puntaje] [int] NOT NULL ,
	[cod_plantillamodulo] [smallint] NULL ,
	[cod_votacion] [int] NULL ,
	[nom_puntaje] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_orden] [smallint] NULL ,
	[num_puntaje] [smallint] NULL ,
	[des_color] [char] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[estadisticas] (
	[cod_nota] [int] NOT NULL ,
	[num_veces] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[filtro] (
	[cod_filtro] [int] IDENTITY (1, 1) NOT NULL ,
	[texto] [varchar] (200) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[forotema] (
	[codigotema] [int] NOT NULL ,
	[sumariotema] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[codigorubro] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[log_gda] (
	[codigo] [int] IDENTITY (1, 1) NOT NULL ,
	[nombre] [varchar] (150) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[ip] [char] (20) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fecha_registro] [datetime] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[notasGDA] (
	[cod_nota] [int] NOT NULL ,
	[cod_seccion] [smallint] NULL ,
	[des_titulonota] [char] (2000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_cabecera] [char] (2000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_texto] [text] COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_autor] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_nombrepagina] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[num_prioridad] [int] NULL ,
	[des_fecha] [varchar] (50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[notas_pdf] (
	[cod_nota] [int] NOT NULL ,
	[cod_seccion] [int] NULL ,
	[cod_publicacion] [int] NULL ,
	[des_titulonota] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_cabecera] [char] (2000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_texto] [text] COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_autor] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_textoauxiliar] [char] (200) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_nombrepagina] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[est_activo] [char] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[fec_registro] [datetime] NULL ,
	[des_pagina] [char] (30) COLLATE SQL_Latin1_General_CP850_CI_AI NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[tempEditorial] (
	[cod_nota] [int] NOT NULL ,
	[des_titulonota] [char] (500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[des_autor] [char] (100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL ,
	[paredes] [varchar] (1) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL ,
	[fec_registro] [datetime] NULL ,
	[num_prioridad] [smallint] NULL ,
	[enlace] [varchar] (75) COLLATE SQL_Latin1_General_CP850_CI_AI NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ArchivosXAsignar] WITH NOCHECK ADD 
	CONSTRAINT [PK_ArchivosXAsignar] PRIMARY KEY  CLUSTERED 
	(
		[ID_ArchivoXAsignar]
	) WITH  FILLFACTOR = 10  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ConstantesModulo] WITH NOCHECK ADD 
	CONSTRAINT [PK__ConstantesModulo__690797E6] PRIMARY KEY  CLUSTERED 
	(
		[cod_registro]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Cuerpo] WITH NOCHECK ADD 
	CONSTRAINT [PK_Cuerpo] PRIMARY KEY  CLUSTERED 
	(
		[ID_Cuerpo]
	) WITH  FILLFACTOR = 10  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[CuerpoFolio] WITH NOCHECK ADD 
	CONSTRAINT [PK_CuerpoFolio] PRIMARY KEY  CLUSTERED 
	(
		[ID_CuerpoFolio]
	) WITH  FILLFACTOR = 10  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Folios] WITH NOCHECK ADD 
	CONSTRAINT [PK_Folios] PRIMARY KEY  CLUSTERED 
	(
		[ID_Folio]
	) WITH  FILLFACTOR = 10  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[NotaComenta] WITH NOCHECK ADD 
	 PRIMARY KEY  CLUSTERED 
	(
		[id_NotaComenta]
	) WITH  FILLFACTOR = 10  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Notas1] WITH NOCHECK ADD 
	CONSTRAINT [PK_Notas1] PRIMARY KEY  CLUSTERED 
	(
		[cod_nota]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[PaginasErradas] WITH NOCHECK ADD 
	CONSTRAINT [PK_PaginasErradas] PRIMARY KEY  CLUSTERED 
	(
		[ID_Pagina]
	) WITH  FILLFACTOR = 10  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Transferencia] WITH NOCHECK ADD 
	CONSTRAINT [PK_Transferencia] PRIMARY KEY  CLUSTERED 
	(
		[cod_Transferencia]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[UsuarioPerfil] WITH NOCHECK ADD 
	CONSTRAINT [PK_UsuarioPerfil] PRIMARY KEY  CLUSTERED 
	(
		[cod_perfil]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[estadisticas] WITH NOCHECK ADD 
	CONSTRAINT [PK_estadisticas] PRIMARY KEY  CLUSTERED 
	(
		[cod_nota]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[filtro] WITH NOCHECK ADD 
	CONSTRAINT [PK_filtro] PRIMARY KEY  CLUSTERED 
	(
		[cod_filtro]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[forotema] WITH NOCHECK ADD 
	CONSTRAINT [PK_forotema] PRIMARY KEY  CLUSTERED 
	(
		[codigotema]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[log_gda] WITH NOCHECK ADD 
	CONSTRAINT [PK_log] PRIMARY KEY  CLUSTERED 
	(
		[codigo]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[notasGDA] WITH NOCHECK ADD 
	CONSTRAINT [PK_notasGDA] PRIMARY KEY  CLUSTERED 
	(
		[cod_nota]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[notas_pdf] WITH NOCHECK ADD 
	CONSTRAINT [PK_notas_pdf] PRIMARY KEY  CLUSTERED 
	(
		[cod_nota]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ArchivosXAsignar] WITH NOCHECK ADD 
	CONSTRAINT [DF_ArchivosXAsignar_Estado] DEFAULT (1) FOR [Estado]
GO

ALTER TABLE [dbo].[Auspicio] WITH NOCHECK ADD 
	CONSTRAINT [DF_Auspicio_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK_Auspicio] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_auspicio]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Cuerpo] WITH NOCHECK ADD 
	CONSTRAINT [DF_Cuerpo_Cod_Estado] DEFAULT (1) FOR [Cod_Estado]
GO

ALTER TABLE [dbo].[Deinteres] WITH NOCHECK ADD 
	CONSTRAINT [DF_Deinteres_est_generado] DEFAULT ('0') FOR [est_generado],
	CONSTRAINT [DF_Deinteres_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_Deinteres_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK__Deinteres__69FBBC1F] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_deinteres]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Encuesta] WITH NOCHECK ADD 
	CONSTRAINT [DF_Encuesta_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_Encuesta_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [DF__Encuesta__msrepl__51FA155C] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK__Encuesta__6AEFE058] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_encuesta]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Foro] WITH NOCHECK ADD 
	CONSTRAINT [PK_Foro] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_foro]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[ForoOpinion] WITH NOCHECK ADD 
	CONSTRAINT [DF_ForoOpinion_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK__ForoOpinion__7B7B4DDC] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_opinion]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Foto] WITH NOCHECK ADD 
	CONSTRAINT [DF_Foto_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK__Foto__6CD828CA] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_foto]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Foto1] WITH NOCHECK ADD 
	CONSTRAINT [DF_Foto1_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [DF__Foto1__msrepl_tra__25077354] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK__Foto1__6CD828CA] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_foto]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[FotoNota] WITH NOCHECK ADD 
	CONSTRAINT [DF_FotoNota_num_prioridad] DEFAULT (0) FOR [num_prioridad],
	CONSTRAINT [DF_FotoNota_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [DF__FotoNota__msrepl__1F4E99FE] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK__FotoNota__6DCC4D03] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_registro]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[FotoNota1] WITH NOCHECK ADD 
	CONSTRAINT [DF_FotoNota1_num_prioridad] DEFAULT (0) FOR [num_prioridad],
	CONSTRAINT [DF_FotoNota1_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [DF__FotoNota1__msrepl__1F4E99FE] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK__FotoNota1__6DCC4D03] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_registro]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Funciones] WITH NOCHECK ADD 
	CONSTRAINT [DF_Funciones_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_Funciones_est_defecto] DEFAULT ('0') FOR [est_defecto],
	CONSTRAINT [DF_Funciones_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK_Funciones] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_funcion]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[LogEncuesta] WITH NOCHECK ADD 
	CONSTRAINT [DF_LogEncuesta_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK__LogEncuesta__6EC0713C] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_registro]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Modulo] WITH NOCHECK ADD 
	CONSTRAINT [DF_Modulo_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_Modulo_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK__Modulo__6FB49575] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_modulo]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[NewsLetter] WITH NOCHECK ADD 
	 PRIMARY KEY  NONCLUSTERED 
	(
		[cod_newsletter]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[NotaAddNewsletter] WITH NOCHECK ADD 
	CONSTRAINT [PK__NotaAddNewslette__719CDDE7] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_nota]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[NotaComenta] WITH NOCHECK ADD 
	CONSTRAINT [DF__NotaComen__bEstN__06C2E356] DEFAULT (1) FOR [bEstNot],
	CONSTRAINT [DF__NotaComen__bEstA__07B7078F] DEFAULT (0) FOR [bEstApr],
	CONSTRAINT [DF__NotaComen__sdFec__08AB2BC8] DEFAULT (getdate()) FOR [sdFecCre],
	CONSTRAINT [DF__NotaComen__vHost__099F5001] DEFAULT (host_name()) FOR [vHost]
GO

ALTER TABLE [dbo].[NotaNewsLetter] WITH NOCHECK ADD 
	CONSTRAINT [PK__NotaNewsLetter__72910220] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_registro]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Notas] WITH NOCHECK ADD 
	CONSTRAINT [DF_Notas_num_prioridad] DEFAULT (0) FOR [num_prioridad],
	CONSTRAINT [DF_Notas_num_prioridadportada] DEFAULT (0) FOR [num_prioridadportada],
	CONSTRAINT [DF_Notas_est_generado] DEFAULT ('0') FOR [est_generado],
	CONSTRAINT [DF_Notas_est_portada] DEFAULT ('0') FOR [est_portada],
	CONSTRAINT [DF_Notas_est_fotoaleatoria] DEFAULT ('0') FOR [est_fotoaleatoria],
	CONSTRAINT [DF_Notas_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_Notas_est_archivo] DEFAULT ('1') FOR [est_archivo],
	CONSTRAINT [DF_Notas_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK_Notas] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_nota]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Notas1] WITH NOCHECK ADD 
	CONSTRAINT [DF_Notas_num_prioridad1] DEFAULT (0) FOR [num_prioridad],
	CONSTRAINT [DF_Notas_num_prioridadportada1] DEFAULT (0) FOR [num_prioridadportada],
	CONSTRAINT [DF_Notas_est_generado1] DEFAULT ('0') FOR [est_generado],
	CONSTRAINT [DF_Notas_est_portada1] DEFAULT ('0') FOR [est_portada],
	CONSTRAINT [DF_Notas_est_fotoaleatoria1] DEFAULT ('0') FOR [est_fotoaleatoria],
	CONSTRAINT [DF_Notas_est_activo1] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_Notas_est_archivo1] DEFAULT ('1') FOR [est_archivo],
	CONSTRAINT [DF_Notas_fec_registro1] DEFAULT (getdate()) FOR [fec_registro]
GO

ALTER TABLE [dbo].[NotasDeinteres] WITH NOCHECK ADD 
	CONSTRAINT [DF_NotasDeinteres_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_NotasDeinteres_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK__NotasDeinteres__74794A92] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_notaDeI]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[NotasRecomendamos] WITH NOCHECK ADD 
	 PRIMARY KEY  NONCLUSTERED 
	(
		[cod_Notasrecomendamos]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[NotasRelacionadas] WITH NOCHECK ADD 
	CONSTRAINT [DF_NotasRelacionadas_num_prioridad] DEFAULT (0) FOR [num_prioridad],
	CONSTRAINT [DF_NotasRelacionadas_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [DF__NotasRela__msrep__13DCE752] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK__NotasRelacionada__76619304] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_relacionNota]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[OpcionEncuesta] WITH NOCHECK ADD 
	CONSTRAINT [DF_OpcionEncuesta_num_acumuladoopcion] DEFAULT (0) FOR [num_acumuladoopcion],
	CONSTRAINT [DF_OpcionEncuesta_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_OpcionEncuesta_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK__OpcionEncuesta__7755B73D] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_opcion]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[PerfilFuncion] WITH NOCHECK ADD 
	CONSTRAINT [PK_PerfilFuncion] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_registro]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Pizarra] WITH NOCHECK ADD 
	CONSTRAINT [DF_Pizarra_fec_vigencia] DEFAULT (getdate() + 90) FOR [fec_vigencia],
	CONSTRAINT [DF_Pizarra_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_Pizarra_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK__Pizarra__7849DB76] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_pizarra]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[PizarraAnuncio] WITH NOCHECK ADD 
	 PRIMARY KEY  NONCLUSTERED 
	(
		[cod_anuncio]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Plantillas] WITH NOCHECK ADD 
	CONSTRAINT [DF_Plantillas_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_Plantillas_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK__Plantillas__7A3223E8] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_plantilla]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[PlantillasModulo] WITH NOCHECK ADD 
	CONSTRAINT [DF_PlantillasModulo_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK__PlantillasModulo__7B264821] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_plantillamodulo]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Publicacion] WITH NOCHECK ADD 
	CONSTRAINT [DF_Publicacion_est_Activo] DEFAULT ('1') FOR [est_Activo],
	CONSTRAINT [DF_Publicacion_est_replicacion] DEFAULT ('N') FOR [est_replicacion],
	CONSTRAINT [DF_Publicacion_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [DF_Publicacion_est_generado] DEFAULT (0) FOR [est_generado],
	CONSTRAINT [DF__Publicaci__msrep__0E240DFC] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK_Publicacion] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_publicacion]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Recomendamos] WITH NOCHECK ADD 
	CONSTRAINT [PK__Recomendamos__190BB0C3] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_recomendamos]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Seccion] WITH NOCHECK ADD 
	CONSTRAINT [DF_Seccion_est_generadoIndice] DEFAULT ('0') FOR [est_generadoIndice],
	CONSTRAINT [DF_Seccion_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [DF_Seccion_est_Activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF__Seccion__msrepl___086B34A6] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK_Seccion] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_seccion]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Servidores] WITH NOCHECK ADD 
	CONSTRAINT [DF_Servidores_est_Activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_Servidores_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK_Servidores] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_servidor]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Suplemento] WITH NOCHECK ADD 
	CONSTRAINT [DF_Suplemento_est_registro] DEFAULT (1) FOR [est_registro]
GO

ALTER TABLE [dbo].[TagIvmaker] WITH NOCHECK ADD 
	CONSTRAINT [DF_TagIvmaker_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_TagIvmaker_est_tipo] DEFAULT ('N') FOR [Tip_tag],
	CONSTRAINT [DF_TagIvmaker_fecha_activo] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK_TagIvmaker] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_tag]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[TamanioFoto] WITH NOCHECK ADD 
	CONSTRAINT [DF_TamanioFoto_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_TamanioFoto_fec_creacion] DEFAULT (getdate()) FOR [fec_creacion],
	CONSTRAINT [PK_TamanioFoto] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_tamanio]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[TamanioFotoPublicacion] WITH NOCHECK ADD 
	CONSTRAINT [DF_TamanioFotoPublicacion_est_defecto] DEFAULT ('0') FOR [est_defecto],
	CONSTRAINT [DF_TamanioFotoPublicacion_est_ampliable] DEFAULT ('0') FOR [est_ampliable],
	CONSTRAINT [DF_TamanioFotoPublicacion_fec_registros] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK_TamanioFotoPublicacion] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_publicacion],
		[cod_tamanio]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[TemaFuncion] WITH NOCHECK ADD 
	CONSTRAINT [DF_TemaFuncion_Tip_tema] DEFAULT ('P') FOR [Tip_tema],
	CONSTRAINT [DF_TmaFuncion_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_TmaFuncion_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK_TmaFuncion] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_tema]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[TemaVideo] WITH NOCHECK ADD 
	CONSTRAINT [DF_TemaVideo_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_TemaVideo_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [PK_TemaVideo] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_tema]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Transferencia] WITH NOCHECK ADD 
	CONSTRAINT [DF_Transferencia_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [DF_Transferencia_est_registro] DEFAULT ('N') FOR [est_registro]
GO

ALTER TABLE [dbo].[Usuario] WITH NOCHECK ADD 
	CONSTRAINT [DF_Usuario_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_Usuario_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [DF_Usuario_tip_nivel] DEFAULT ('U') FOR [tip_nivel],
	CONSTRAINT [DF_Usuario_flg_ftp] DEFAULT ('N') FOR [flg_ftp],
	CONSTRAINT [PK_Usuario] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_usuario]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[UsuarioPerfil] WITH NOCHECK ADD 
	CONSTRAINT [DF_UsuarioPerfil_fec_registro] DEFAULT (getdate()) FOR [fec_registro]
GO

ALTER TABLE [dbo].[Video] WITH NOCHECK ADD 
	CONSTRAINT [DF_Video_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_Video_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [DF__Video__msrepl_tr__02B25B50] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK__Video__7EF6D905] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_video]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[VideoNota] WITH NOCHECK ADD 
	CONSTRAINT [DF_VideoNota_est_activo] DEFAULT ('1') FOR [est_activo],
	CONSTRAINT [DF_VideoNota_fec_registro] DEFAULT (getdate()) FOR [fec_registro],
	CONSTRAINT [DF__VideoNota__msrep__4D6A6A69] DEFAULT (newid()) FOR [msrepl_tran_version],
	CONSTRAINT [PK__VideoNota__7FEAFD3E] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_registro]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[VideoSeccion] WITH NOCHECK ADD 
	CONSTRAINT [PK__VideoSeccion__00DF2177] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_videoseccion]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Votacion] WITH NOCHECK ADD 
	CONSTRAINT [PK__Votacion__01D345B0] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_votacion]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[VotacionOpinion] WITH NOCHECK ADD 
	CONSTRAINT [PK__VotacionOpinion__32CB82C6] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_opinion]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[VotacionPuntaje] WITH NOCHECK ADD 
	CONSTRAINT [PK__VotacionPuntaje__33BFA6FF] PRIMARY KEY  NONCLUSTERED 
	(
		[cod_puntaje]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[estadisticas] WITH NOCHECK ADD 
	CONSTRAINT [DF_estadisticas_num_veces] DEFAULT (0) FOR [num_veces]
GO

ALTER TABLE [dbo].[log_gda] WITH NOCHECK ADD 
	CONSTRAINT [DF_log_fecha_registro] DEFAULT (getdate()) FOR [fecha_registro]
GO

ALTER TABLE [dbo].[notas_pdf] WITH NOCHECK ADD 
	CONSTRAINT [DF_notas_pdf_fec_registro] DEFAULT (getdate()) FOR [fec_registro]
GO

 CREATE  UNIQUE  INDEX [XPKAuspicio] ON [dbo].[Auspicio]([cod_auspicio]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKConstantesModulo] ON [dbo].[ConstantesModulo]([cod_registro]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF43ConstantesModulo] ON [dbo].[ConstantesModulo]([cod_modulo]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [IX_Cuerpo] ON [dbo].[Cuerpo]([Cod_Cuerpo]) WITH  FILLFACTOR = 10 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKDeinteres] ON [dbo].[Deinteres]([cod_deinteres]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF39Deinteres] ON [dbo].[Deinteres]([cod_seccion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKEncuesta] ON [dbo].[Encuesta]([cod_encuesta]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF78Encuesta] ON [dbo].[Encuesta]([cod_publicacion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [IX_Folios] ON [dbo].[Folios]([Cod_Folio]) WITH  FILLFACTOR = 10 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKForo] ON [dbo].[Foro]([cod_foro]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF66Foro] ON [dbo].[Foro]([cod_nota]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF68Foro] ON [dbo].[Foro]([cod_auspicio]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKForoOpinion] ON [dbo].[ForoOpinion]([cod_opinion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF70ForoOpinion] ON [dbo].[ForoOpinion]([cod_foro]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKFoto] ON [dbo].[Foto]([cod_foto], [cod_publicacion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [IX_Foto] ON [dbo].[Foto]([fec_registro] DESC , [des_nombrearchivo]) ON [PRIMARY]
GO

 CREATE  INDEX [idx_foto1] ON [dbo].[Foto]([cod_publicacion], [fec_registro]) WITH  FILLFACTOR = 10 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKFoto] ON [dbo].[Foto1]([cod_foto], [cod_publicacion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [IX_Foto] ON [dbo].[Foto1]([fec_registro] DESC , [des_nombrearchivo]) WITH  FILLFACTOR = 10 ON [PRIMARY]
GO

 CREATE  INDEX [idx_foto1] ON [dbo].[Foto1]([cod_publicacion], [fec_registro]) WITH  FILLFACTOR = 10 ON [PRIMARY]
GO

 CREATE  INDEX [FotoNota_cod_foto_cod_nota] ON [dbo].[FotoNota]([cod_nota], [cod_foto]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [FotoNota_cod_foto_cod_nota] ON [dbo].[FotoNota1]([cod_nota], [cod_foto]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKFunciones] ON [dbo].[Funciones]([cod_funcion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKLogEncuesta] ON [dbo].[LogEncuesta]([cod_registro]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF77LogEncuesta] ON [dbo].[LogEncuesta]([cod_encuesta]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF81LogEncuesta] ON [dbo].[LogEncuesta]([cod_opcion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKModulo] ON [dbo].[Modulo]([cod_modulo]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKNewsLetter] ON [dbo].[NewsLetter]([cod_newsletter]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF54NewsLetter] ON [dbo].[NewsLetter]([cod_auspicio]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKNotaAddNewsletter] ON [dbo].[NotaAddNewsletter]([cod_nota]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF33NotaAddNewsletter] ON [dbo].[NotaAddNewsletter]([cod_newsletter]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKNotaNewsLetter] ON [dbo].[NotaNewsLetter]([cod_registro]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF31NotaNewsLetter] ON [dbo].[NotaNewsLetter]([cod_newsletter]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF32NotaNewsLetter] ON [dbo].[NotaNewsLetter]([cod_nota]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF38NotaNewsLetter] ON [dbo].[NotaNewsLetter]([cod_nota]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKNotas] ON [dbo].[Notas]([cod_seccion], [cod_nota]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [idx_titulares] ON [dbo].[Notas]([cod_seccion], [est_activo], [cod_nota], [des_tituloNota], [est_archivo], [num_prioridad]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [idx_portada] ON [dbo].[Notas]([cod_publicacion], [cod_seccion], [num_prioridad], [est_activo]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [idx_seccion] ON [dbo].[Notas]([cod_seccion], [cod_nota]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [idx4_notas] ON [dbo].[Notas]([cod_seccion], [fec_registro]) WITH  FILLFACTOR = 10 ON [PRIMARY]
GO

 CREATE  INDEX [idx_notas6] ON [dbo].[Notas]([est_activo], [cod_publicacion], [cod_seccion], [cod_nota]) WITH  FILLFACTOR = 10 ON [PRIMARY]
GO

 CREATE  INDEX [despagina] ON [dbo].[Notas]([est_activo], [fec_registro], [des_pagina]) WITH  FILLFACTOR = 10 ON [PRIMARY]
GO

 CREATE  INDEX [idx_impresa] ON [dbo].[Notas]([cod_publicacion], [fec_registro], [des_pagina], [cod_auspicio], [num_prioridad]) WITH  FILLFACTOR = 10 ON [PRIMARY]
GO

 CREATE  INDEX [publicacion_ind] ON [dbo].[Notas]([cod_publicacion]) WITH  FILLFACTOR = 10 ON [PRIMARY]
GO

 CREATE  INDEX [est_Activo_ind] ON [dbo].[Notas]([est_activo]) WITH  FILLFACTOR = 10 ON [PRIMARY]
GO

 CREATE  INDEX [est_archivo_ind] ON [dbo].[Notas]([est_archivo]) WITH  FILLFACTOR = 10 ON [PRIMARY]
GO

 CREATE  INDEX [Idx_des_pagina_2] ON [dbo].[Notas]([des_pagina], [cod_publicacion], [cod_seccion], [fec_registro]) ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKNotasDeinteres] ON [dbo].[NotasDeinteres]([cod_notaDeI]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF34NotasDeinteres] ON [dbo].[NotasDeinteres]([cod_deinteres]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKNotasRecomendamos] ON [dbo].[NotasRecomendamos]([cod_Notasrecomendamos]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF36NotasRecomendamos] ON [dbo].[NotasRecomendamos]([cod_recomendamos]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF55NotasRecomendamos] ON [dbo].[NotasRecomendamos]([cod_auspicio]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF26NotasRelacionadas] ON [dbo].[NotasRelacionadas]([cod_nota], [num_prioridad]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKOpcionEncuesta] ON [dbo].[OpcionEncuesta]([cod_opcion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF76OpcionEncuesta] ON [dbo].[OpcionEncuesta]([cod_encuesta]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKUsuarioFuncion] ON [dbo].[PerfilFuncion]([cod_registro]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF12UsuarioFuncion] ON [dbo].[PerfilFuncion]([cod_funcion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF84UsuarioFuncion] ON [dbo].[PerfilFuncion]([cod_usuario]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKPizarra] ON [dbo].[Pizarra]([cod_pizarra]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF72Pizarra] ON [dbo].[Pizarra]([cod_seccion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF73Pizarra] ON [dbo].[Pizarra]([cod_publicacion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF74Pizarra] ON [dbo].[Pizarra]([cod_auspicio]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF75Pizarra] ON [dbo].[Pizarra]([cod_plantillamodulo]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKPizarraAnuncio] ON [dbo].[PizarraAnuncio]([cod_anuncio]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF71PizarraAnuncio] ON [dbo].[PizarraAnuncio]([cod_pizarra]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKPlantillas] ON [dbo].[Plantillas]([cod_plantilla]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF44Plantillas] ON [dbo].[Plantillas]([cod_publicacion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKPlantillasModulo] ON [dbo].[PlantillasModulo]([cod_plantillamodulo]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF58PlantillasModulo] ON [dbo].[PlantillasModulo]([cod_modulo]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF16PublicacionModulo] ON [dbo].[PublicacionModulo]([cod_publicacion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF9PublicacionModulo] ON [dbo].[PublicacionModulo]([cod_modulo]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKRecomendamos] ON [dbo].[Recomendamos]([cod_recomendamos]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF40Recomendamos] ON [dbo].[Recomendamos]([cod_publicacion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF80Recomendamos] ON [dbo].[Recomendamos]([cod_plantillamodulo]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKSeccion] ON [dbo].[Seccion]([cod_publicacion], [cod_seccion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF18Seccion] ON [dbo].[Seccion]([cod_plantilla]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKServidores] ON [dbo].[Servidores]([cod_servidor]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [edx_tamest] ON [dbo].[TamanioFotoPublicacion]([cod_publicacion], [est_defecto], [cod_tamanio]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKTemaVideo] ON [dbo].[TemaVideo]([cod_tema]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKUsuario] ON [dbo].[Usuario]([cod_usuario]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKUsuarioAsignacion] ON [dbo].[UsuarioPerfil]([cod_perfil]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF10UsuarioAsignacion] ON [dbo].[UsuarioPerfil]([cod_usuario]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF17UsuarioAsignacion] ON [dbo].[UsuarioPerfil]([cod_seccion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF82UsuarioAsignacion] ON [dbo].[UsuarioPerfil]([cod_publicacion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKVideo] ON [dbo].[Video]([cod_video]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF35Video] ON [dbo].[Video]([cod_tema]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKVideoNota] ON [dbo].[VideoNota]([cod_registro]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF37VideoNota] ON [dbo].[VideoNota]([cod_video]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF42VideoNota] ON [dbo].[VideoNota]([cod_nota]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF47VideoNota] ON [dbo].[VideoNota]([cod_auspicio]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKVideoSeccion] ON [dbo].[VideoSeccion]([cod_videoseccion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF46VideoSeccion] ON [dbo].[VideoSeccion]([cod_plantilla]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF51VideoSeccion] ON [dbo].[VideoSeccion]([cod_seccion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF53VideoSeccion] ON [dbo].[VideoSeccion]([cod_auspicio]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKVotacion] ON [dbo].[Votacion]([cod_votacion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF63Votacion] ON [dbo].[Votacion]([cod_nota]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF64Votacion] ON [dbo].[Votacion]([cod_auspicio]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKVotacionOpinion] ON [dbo].[VotacionOpinion]([cod_opinion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF59VotacionOpinion] ON [dbo].[VotacionOpinion]([cod_plantillamodulo]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF60VotacionOpinion] ON [dbo].[VotacionOpinion]([cod_votacion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  UNIQUE  INDEX [XPKVotacionPuntaje] ON [dbo].[VotacionPuntaje]([cod_puntaje]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF61VotacionPuntaje] ON [dbo].[VotacionPuntaje]([cod_votacion]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [XIF65VotacionPuntaje] ON [dbo].[VotacionPuntaje]([cod_plantillamodulo]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [idx2] ON [dbo].[notas_pdf]([fec_registro]) WITH  FILLFACTOR = 10 ON [PRIMARY]
GO

 CREATE  INDEX [notaspdf_idx] ON [dbo].[notas_pdf]([des_pagina]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ConstantesModulo] ADD 
	CONSTRAINT [FK_ConstantesModulo_Modulo] FOREIGN KEY 
	(
		[cod_modulo]
	) REFERENCES [dbo].[Modulo] (
		[cod_modulo]
	)
GO

ALTER TABLE [dbo].[CuerpoFolio] ADD 
	CONSTRAINT [FK_CuerpoFolio_Cuerpo] FOREIGN KEY 
	(
		[ID_Cuerpo]
	) REFERENCES [dbo].[Cuerpo] (
		[ID_Cuerpo]
	),
	CONSTRAINT [FK_CuerpoFolio_Folios] FOREIGN KEY 
	(
		[ID_Folio]
	) REFERENCES [dbo].[Folios] (
		[ID_Folio]
	)
GO

ALTER TABLE [dbo].[ForoOpinion] ADD 
	CONSTRAINT [FK_ForoOpinion_Foro] FOREIGN KEY 
	(
		[cod_foro]
	) REFERENCES [dbo].[Foro] (
		[cod_foro]
	)
GO

ALTER TABLE [dbo].[FotoNota] ADD 
	CONSTRAINT [FK__FotoNota__cod_fo__0697FACD] FOREIGN KEY 
	(
		[cod_foto]
	) REFERENCES [dbo].[Foto] (
		[cod_foto]
	)
GO

ALTER TABLE [dbo].[FotoNota1] ADD 
	CONSTRAINT [FK__FotoNota1__cod_fo__0697FACD] FOREIGN KEY 
	(
		[cod_foto]
	) REFERENCES [dbo].[Foto1] (
		[cod_foto]
	)
GO

ALTER TABLE [dbo].[Funciones] ADD 
	CONSTRAINT [FK_Funciones_TemaFuncion] FOREIGN KEY 
	(
		[cod_tema]
	) REFERENCES [dbo].[TemaFuncion] (
		[cod_tema]
	)
GO

ALTER TABLE [dbo].[LogEncuesta] ADD 
	CONSTRAINT [FK__LogEncues__cod_e__0880433F] FOREIGN KEY 
	(
		[cod_encuesta]
	) REFERENCES [dbo].[Encuesta] (
		[cod_encuesta]
	),
	CONSTRAINT [FK__LogEncues__cod_o__09746778] FOREIGN KEY 
	(
		[cod_opcion]
	) REFERENCES [dbo].[OpcionEncuesta] (
		[cod_opcion]
	)
GO

ALTER TABLE [dbo].[NotaAddNewsletter] ADD 
	CONSTRAINT [FK__NotaAddNe__cod_n__0B5CAFEA] FOREIGN KEY 
	(
		[cod_newsletter]
	) REFERENCES [dbo].[NewsLetter] (
		[cod_newsletter]
	)
GO

ALTER TABLE [dbo].[NotaNewsLetter] ADD 
	CONSTRAINT [FK__NotaNewsL__cod_n__0C50D423] FOREIGN KEY 
	(
		[cod_newsletter]
	) REFERENCES [dbo].[NewsLetter] (
		[cod_newsletter]
	),
	CONSTRAINT [FK__NotaNewsL__cod_n__0D44F85C] FOREIGN KEY 
	(
		[cod_nota]
	) REFERENCES [dbo].[NotaAddNewsletter] (
		[cod_nota]
	),
	CONSTRAINT [FK__NotaNewsL__cod_n__0E391C95] FOREIGN KEY 
	(
		[cod_nota]
	) REFERENCES [dbo].[Notas] (
		[cod_nota]
	) NOT FOR REPLICATION 
GO

alter table [dbo].[NotaNewsLetter] nocheck constraint [FK__NotaNewsL__cod_n__0E391C95]
GO

ALTER TABLE [dbo].[NotasDeinteres] ADD 
	CONSTRAINT [FK__NotasDein__cod_d__0F2D40CE] FOREIGN KEY 
	(
		[cod_deinteres]
	) REFERENCES [dbo].[Deinteres] (
		[cod_deinteres]
	)
GO

ALTER TABLE [dbo].[NotasRecomendamos] ADD 
	CONSTRAINT [FK__NotasReco__cod_r__48BAC3E5] FOREIGN KEY 
	(
		[cod_recomendamos]
	) REFERENCES [dbo].[Recomendamos] (
		[cod_recomendamos]
	)
GO

ALTER TABLE [dbo].[OpcionEncuesta] ADD 
	CONSTRAINT [FK__OpcionEnc__cod_e__12FDD1B2] FOREIGN KEY 
	(
		[cod_encuesta]
	) REFERENCES [dbo].[Encuesta] (
		[cod_encuesta]
	)
GO

ALTER TABLE [dbo].[Pizarra] ADD 
	CONSTRAINT [FK__Pizarra__cod_pla__16CE6296] FOREIGN KEY 
	(
		[cod_plantillamodulo]
	) REFERENCES [dbo].[PlantillasModulo] (
		[cod_plantillamodulo]
	)
GO

ALTER TABLE [dbo].[PizarraAnuncio] ADD 
	CONSTRAINT [FK__PizarraAn__cod_p__17C286CF] FOREIGN KEY 
	(
		[cod_pizarra]
	) REFERENCES [dbo].[Pizarra] (
		[cod_pizarra]
	)
GO

ALTER TABLE [dbo].[Plantillas] ADD 
	CONSTRAINT [FK_Plantillas_Publicacion1] FOREIGN KEY 
	(
		[cod_publicacion]
	) REFERENCES [dbo].[Publicacion] (
		[cod_publicacion]
	)
GO

alter table [dbo].[Plantillas] nocheck constraint [FK_Plantillas_Publicacion1]
GO

ALTER TABLE [dbo].[PlantillasModulo] ADD 
	CONSTRAINT [FK__Plantilla__cod_m__19AACF41] FOREIGN KEY 
	(
		[cod_modulo]
	) REFERENCES [dbo].[Modulo] (
		[cod_modulo]
	)
GO

ALTER TABLE [dbo].[Publicacion] ADD 
	CONSTRAINT [FK_Publicacion_Auspicio] FOREIGN KEY 
	(
		[cod_auspicio]
	) REFERENCES [dbo].[Auspicio] (
		[cod_auspicio]
	),
	CONSTRAINT [FK_Publicacion_Servidores] FOREIGN KEY 
	(
		[cod_servidor]
	) REFERENCES [dbo].[Servidores] (
		[cod_servidor]
	)
GO

alter table [dbo].[Publicacion] nocheck constraint [FK_Publicacion_Auspicio]
GO

alter table [dbo].[Publicacion] nocheck constraint [FK_Publicacion_Servidores]
GO

ALTER TABLE [dbo].[PublicacionModulo] ADD 
	CONSTRAINT [FK__Publicaci__cod_m__1C873BEC] FOREIGN KEY 
	(
		[cod_modulo]
	) REFERENCES [dbo].[Modulo] (
		[cod_modulo]
	),
	CONSTRAINT [FK_PublicacionModulo_Publicacion] FOREIGN KEY 
	(
		[cod_publicacion]
	) REFERENCES [dbo].[Publicacion] (
		[cod_publicacion]
	)
GO

alter table [dbo].[PublicacionModulo] nocheck constraint [FK__Publicaci__cod_m__1C873BEC]
GO

alter table [dbo].[PublicacionModulo] nocheck constraint [FK_PublicacionModulo_Publicacion]
GO

ALTER TABLE [dbo].[Recomendamos] ADD 
	CONSTRAINT [FK__Recomenda__cod_p__1E6F845E] FOREIGN KEY 
	(
		[cod_plantillamodulo]
	) REFERENCES [dbo].[PlantillasModulo] (
		[cod_plantillamodulo]
	)
GO

ALTER TABLE [dbo].[TamanioFotoPublicacion] ADD 
	CONSTRAINT [FK_TamanioFotoPublicacion_TamanioFoto] FOREIGN KEY 
	(
		[cod_tamanio]
	) REFERENCES [dbo].[TamanioFoto] (
		[cod_tamanio]
	)
GO

ALTER TABLE [dbo].[UsuarioPerfil] ADD 
	CONSTRAINT [FK_UsuarioPerfil_Publicacion] FOREIGN KEY 
	(
		[cod_publicacion]
	) REFERENCES [dbo].[Publicacion] (
		[cod_publicacion]
	),
	CONSTRAINT [FK_UsuarioPerfil_Usuario] FOREIGN KEY 
	(
		[cod_usuario]
	) REFERENCES [dbo].[Usuario] (
		[cod_usuario]
	)
GO

alter table [dbo].[UsuarioPerfil] nocheck constraint [FK_UsuarioPerfil_Publicacion]
GO

ALTER TABLE [dbo].[VideoSeccion] ADD 
	CONSTRAINT [FK__VideoSecc__cod_p__2704CA5F] FOREIGN KEY 
	(
		[cod_plantilla]
	) REFERENCES [dbo].[Plantillas] (
		[cod_plantilla]
	)
GO

ALTER TABLE [dbo].[Votacion] ADD 
	CONSTRAINT [FK__Votacion__cod_no__29E1370A] FOREIGN KEY 
	(
		[cod_nota]
	) REFERENCES [dbo].[Notas] (
		[cod_nota]
	) NOT FOR REPLICATION 
GO

alter table [dbo].[Votacion] nocheck constraint [FK__Votacion__cod_no__29E1370A]
GO

ALTER TABLE [dbo].[VotacionOpinion] ADD 
	CONSTRAINT [FK__VotacionO__cod_p__2BC97F7C] FOREIGN KEY 
	(
		[cod_plantillamodulo]
	) REFERENCES [dbo].[PlantillasModulo] (
		[cod_plantillamodulo]
	),
	CONSTRAINT [FK__VotacionO__cod_v__2CBDA3B5] FOREIGN KEY 
	(
		[cod_votacion]
	) REFERENCES [dbo].[Votacion] (
		[cod_votacion]
	)
GO

ALTER TABLE [dbo].[VotacionPuntaje] ADD 
	CONSTRAINT [FK__VotacionP__cod_p__2EA5EC27] FOREIGN KEY 
	(
		[cod_plantillamodulo]
	) REFERENCES [dbo].[PlantillasModulo] (
		[cod_plantillamodulo]
	),
	CONSTRAINT [FK__VotacionP__cod_v__2DB1C7EE] FOREIGN KEY 
	(
		[cod_votacion]
	) REFERENCES [dbo].[Votacion] (
		[cod_votacion]
	)
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE	PROCEDURE ECW_IVMK_SP_ACTUALIZARNOTAS_TEMP
AS
BEGIN
	SET NOCOUNT ON
/**********************************************************************************************
	DE DECLARACIÓN DE VARIABLES DE CONTROL DE ERROR PARA PORTADA IMPRESA Y SUPLEMENTO
**********************************************************************************************/
	DECLARE	@ERR_DEL_IMPRESA INT
	DECLARE	@ERR_INS_IMPRESA INT
	DECLARE	@ERR_DEL_SUPLEMENTO INT
	DECLARE	@ERR_INS_SUPLEMENTO INT

	DECLARE	@CONT_IMPRESA 	INT
	DECLARE	@CONT_SUPLEMENTO INT
	DECLARE	@DES_PAGINA 	CHAR(12)
	DECLARE	@NUM_DIA 	INT
	DECLARE	@EST_GENERADO 	INT

	SET 	@EST_GENERADO = (SELECT ISNULL(EST_GENERADO, '0') FROM PUBLICACION WHERE COD_PUBLICACION = 59)

	IF 	@EST_GENERADO = '1' 
	BEGIN
		/**********************************************************************************************
		INICIO DE LA TRANSACCIÓN PORTADA IMPRESA
		**********************************************************************************************/
		BEGIN 	TRANSACTION TR_IMPRESA
		SET 	@DES_PAGINA = (	SELECT	DISTINCT TOP 1 RTRIM(LTRIM(DES_PAGINA))
					FROM	NOTAS 
					WHERE	FEC_REGISTRO >= GETDATE() -1
						AND DES_PAGINA LIKE 'ECPR%' 
						AND DES_PAGINA LIKE '%A1'
						AND COD_PUBLICACION = 59 
						AND DES_PAGINA <> ''
						AND EST_ACTIVO = '1'
					ORDER	BY RTRIM(LTRIM(DES_PAGINA)) DESC
					)
		
		SET @CONT_IMPRESA = (	SELECT	COUNT(*)
					FROM	NOTAS 
					WHERE	DES_PAGINA = @DES_PAGINA
						AND COD_PUBLICACION = 59 
						AND DES_PAGINA <> ''
						AND EST_ACTIVO = '1'
						AND CONVERT(CHAR(10), FEC_REGISTRO, 102) >= CONVERT(CHAR(10), GETDATE() -1, 102) 
					)
	
		--Si estamos entre las 2am y 8am y el número de Notas de Edicion Impresa del día es >= 8
		IF @CONT_IMPRESA >= 7 
		BEGIN
			--Eliminar todas las notas de tipo Edicion Impresa de la tabla temporal.
			DELETE	FROM NOTAS_TEMP WHERE COD_PUBLICACION = 59 AND COD_SECCION = 424
			SET 	@ERR_DEL_IMPRESA = @@ERROR
	
			--Ingresar las notas de Edicion Impresa, de la sección del día, en la tabla temporal.
			INSERT 	INTO NOTAS_TEMP (cod_nota, cod_publicacion, cod_usuario, cod_seccion, cod_auspicio, cod_plantilla, des_tituloNota, des_cabecera, des_volada, des_texto, des_autor, des_textoauxiliar, des_nombrepagina, num_prioridad, num_prioridadportada, est_generado, est_portada, est_fotoaleatoria, est_activo, est_archivo, fec_registro, des_pagina, fec_Transaccion)
			SELECT	*, GETDATE() FROM NOTAS WHERE DES_PAGINA = @DES_PAGINA AND COD_PUBLICACION = 59 AND DES_PAGINA <> '' AND EST_ACTIVO = '1'
			SET 	@ERR_INS_IMPRESA = @@ERROR
		END
		
		IF @ERR_DEL_IMPRESA = 0 AND @ERR_INS_IMPRESA = 0 
			COMMIT TRANSACTION TR_IMPRESA
		ELSE
			ROLLBACK TRANSACTION TR_IMPRESA
	
		/**********************************************************************************************
		INICIO DE LA TRANSACCIÓN PORTADA SUPLEMENTO
		**********************************************************************************************/
		BEGIN 	TRANSACTION TR_SUPLEMENTO
		
		--@NUM_DIA : 1 domingo, 2 lunes, 3 mar,4 mier.,5 juev, 6 vier,7 sab
		SET 	@NUM_DIA = (SELECT DATEPART(WEEKDAY, GETDATE()))
	
		SET 	@CONT_SUPLEMENTO = (	SELECT	COUNT(*)
						FROM	NOTAS
						WHERE	COD_SECCION = 
								(SELECT	DISTINCT TOP 1 COD_SECCION
								FROM	Suplemento_Dia s
								WHERE	s.NRO_DIA = @NUM_DIA
								AND s.EST_ACTIVO = '1')
							AND EST_ACTIVO = '1' 
							AND EST_ARCHIVO = '1'
--							AND DES_PAGINA <> ''
							AND COD_PUBLICACION = 59
							AND CONVERT(CHAR(10), FEC_REGISTRO, 102) >= CONVERT(CHAR(10), GETDATE() -1, 102) 
						)
		--Si estamos entre las 2am y 8am y el número de suplementos del día es >= 4
		IF @CONT_SUPLEMENTO >= 4
		BEGIN
			--Eliminar todas las notas de tipo suplemento de la tabla temporal.
			DELETE	FROM NOTAS_TEMP WHERE COD_PUBLICACION = 59 AND COD_SECCION <> '424'	-- Sección diferente de portada(424)
	
			SET 	@ERR_DEL_SUPLEMENTO = @@ERROR
			
			--Ingresar las notas de tipo suplemento, de la sección del día, en la tabla temporal.
			INSERT 	INTO NOTAS_TEMP (cod_nota, cod_publicacion, cod_usuario, cod_seccion, cod_auspicio, cod_plantilla, des_tituloNota, des_cabecera, des_volada, des_texto, des_autor, des_textoauxiliar, des_nombrepagina, num_prioridad, num_prioridadportada, est_generado, est_portada, est_fotoaleatoria, est_activo, est_archivo, fec_registro, des_pagina, fec_Transaccion)
			SELECT	cod_nota, cod_publicacion, cod_usuario, cod_seccion, cod_auspicio, cod_plantilla, des_tituloNota, des_cabecera, des_volada, des_texto, des_autor, des_textoauxiliar, des_nombrepagina, num_prioridad, num_prioridadportada, est_generado, est_portada, est_fotoaleatoria, est_activo, est_archivo, fec_registro, des_pagina, GETDATE()
			FROM 	NOTAS 
			WHERE	COD_SECCION = (SELECT DISTINCT TOP 1 COD_SECCION FROM Suplemento_Dia s WHERE s.NRO_DIA = @NUM_DIA AND s.EST_ACTIVO = '1')
				AND EST_ACTIVO = '1'
				AND EST_ARCHIVO = '1'
--				AND DES_PAGINA <> ''
				AND COD_PUBLICACION = 59
				AND CONVERT(CHAR(10), FEC_REGISTRO, 102) >= CONVERT(CHAR(10), GETDATE() -1, 102) 
	
			SET 	@ERR_INS_SUPLEMENTO = @@ERROR
		END
		
		IF @ERR_DEL_SUPLEMENTO = 0 AND @ERR_INS_SUPLEMENTO = 0 
			COMMIT TRANSACTION TR_SUPLEMENTO
		ELSE
			ROLLBACK TRANSACTION TR_SUPLEMENTO
	END

/**********************************************************************************************
	ACTUALIZA EL FLAG DE GENERACION DE PUBLICACION DE LA EDICION IMPRESA A CERO SI ES QUE SE ENCUENTRA ENTRE LAS 04:00pm y las 04:00am del dia sgte.
**********************************************************************************************/
	UPDATE	Publicacion
	SET	EST_GENERADO = '0'
	WHERE	cod_publicacion = 59
		AND CONVERT(DATETIME, GETDATE(), 120) 
		BETWEEN  CONVERT(DATETIME, DATEADD(minute, 960, CONVERT(char(10), (SELECT TOP 1 FEC_TRANSACCION FROM NOTAS_TEMP ORDER BY FEC_TRANSACCION DESC), 120)), 120)
		AND CONVERT(DATETIME, DATEADD(minute, 1680, CONVERT(char(10), (SELECT TOP 1 FEC_TRANSACCION FROM NOTAS_TEMP ORDER BY FEC_TRANSACCION DESC), 120)), 120)

/**********************************************************************************************
	CONSULTA PARA TRAER EL GRAFICO DE LA PAGINA DE LA EDICION IMPRESA Y MOSTRARLA EN LA PORTADA ONLINE.
**********************************************************************************************/
	SELECT	DISTINCT ('/edicionimpresa/html/' + CONVERT(CHAR(10), FEC_TRANSACCION, 120) + '/' + rtrim(DES_PAGINA)+ '_chico.jpg') AS RUTA_IMAGENIMPRESA, 
		RTRIM(LTRIM(DES_PAGINA)) AS DES_PAGINA,
		CONVERT(CHAR(10), FEC_REGISTRO, 103) AS FEC_REGISTRO
	FROM	IVMAKER..NOTAS_TEMP
	WHERE	CONVERT(CHAR(10), FEC_REGISTRO, 102) >= CONVERT(CHAR(10), GETDATE() -1, 102)
		AND DES_PAGINA LIKE 'ECPR%' 
		AND DES_PAGINA LIKE '%A1'
		AND COD_PUBLICACION = 59 
		AND DES_PAGINA <> ''
		AND EST_ACTIVO = '1'
	ORDER	BY RTRIM(LTRIM(DES_PAGINA)) DESC

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE	PROC ECW_IVMK_SP_SEL_NOTASIMPRESA_TEMP
AS
BEGIN
	SELECT  a.*, b.NOM_SECCION AS SECCION, CONVERT(CHAR(10), a.FEC_REGISTRO, 120) AS FECHA_URL
	FROM    NOTAS_TEMP a 
	INNER 	JOIN SECCION b ON a.COD_SECCION = b.COD_SECCION AND b.EST_ACTIVO = '1'
	WHERE   a.COD_SECCION = '424' AND a.EST_ACTIVO = '1'
	ORDER 	BY a.NUM_PRIORIDAD
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE	PROC ECW_IVMK_SP_SEL_SUPLEMENTO_TEMP
AS
BEGIN
	--Seleccionamos todas las notas distintas de portada(solo debe existir notas del día, ya que previamente se eliminaron).
	SELECT  *,
		(SELECT	DISTINCT TOP 1 ALIAS_SECCION
		FROM	Suplemento_Dia
		WHERE	NRO_DIA = (SELECT DATEPART(WEEKDAY, GETDATE()))	
			AND EST_ACTIVO = '1'
		) AS SECCION, 
--		Seleccionamos la fecha de transacción como fecha de enlace debido a que nos puede llegar una nota ingresada un dia antes.
--		CONVERT(CHAR(10), FEC_TRANSACCION, 120) AS FECHA_URL

--		Se cambió la condición de fecha el día 21/11/07, debido a que el día lunes 19/11/07 en la noche se ingresó una nota 
--		que era para el dia sgte. martes 20/11/07 y no jalaba correctamente el enlace.
		CONVERT(CHAR(10), FEC_REGISTRO, 120) AS FECHA_URL
	FROM    NOTAS_TEMP 
	WHERE   COD_SECCION <> '424'	-- Sección diferente de portada(424)
		AND EST_ACTIVO = '1'
	ORDER 	BY NUM_PRIORIDAD
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE	PROC ECW_SP_PORTADA_EDIMPRESA_SEL
AS
BEGIN
	DECLARE @FECHA CHAR(10)
	SET	@FECHA = CONVERT(CHAR(10), GETDATE(), 120)
		
	SELECT	DISTINCT ('/edicionimpresa/html/' + @FECHA + '/' + rtrim(DES_PAGINA)+ '_chico.jpg') AS RUTA_IMAGENIMPRESA , des_pagina,
		CONVERT(CHAR(10), FEC_REGISTRO, 103) AS FEC_REGISTRO
		--, FEC_REGISTRO
	FROM	IVMAKER..NOTAS 
	WHERE	FEC_REGISTRO > GETDATE()-1
		AND DES_PAGINA LIKE 'ECPR%' 
		AND DES_PAGINA LIKE '%A1'
		AND COD_PUBLICACION = 59 
		AND DES_PAGINA <> ''
	ORDER	BY FEC_REGISTRO DESC
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE procedure GrabaNotaPDF
	@varCodNota int,
	@varseccion int,
	@vartitulo char(1000), 
   	@varcabecera char(2000),
	@vartexto varchar(5000),
	@varautor  char(150),
	@varvolada char(500),
	@varPagina char(30)
as
declare @varcodpublicacion int,
	@varcodPlantilla int,
	@codnota int,
	@codfoto int,
	@imagen varchar(30),
	@pos int

select @varcodpublicacion = cod_publicacion,@varcodPlantilla=cod_plantilladefectonota from seccion where cod_seccion=@varseccion

insert into notas_pdf (cod_nota,cod_seccion,cod_publicacion,des_titulonota, des_cabecera, des_texto, des_autor,des_textoauxiliar,des_pagina)
values (@varCodNota,@varseccion,@varcodpublicacion,@vartitulo,@varcabecera,@vartexto,@varautor,@varvolada,@varPagina)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE GrabaNota

	@varSeccion int,
	@varTitulo char(500), 
           @varCabecera char(2000),
	@varTexto text,
	@vnomImage char(30),
	@varAutor  char(100)
AS
declare @varCodPublicacion int,
	@CodNota int,
	@CodFoto int

select @varCodPublicacion = cod_publicacion from seccion where cod_seccion=@varSeccion

insert notas (cod_publicacion, cod_Seccion, des_tituloNota, des_cabecera, des_texto, des_autor)
values (@varCodPublicacion,@varSeccion,@varTitulo,@varCabecera,@varTexto,@varAutor)

select @CodNota = @@identity from nota

insert foto (cod_publicacion, des_nombrearchivo,fec_registro )
values (@varCodPublicacion,@vnomImage,getdate() )

select @CodFoto = @@identity from Foto

insert fotonota (cod_nota, cod_foto, num_prioridad)
values (@CodNota, @CodFoto,0)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE procedure IAR_sp_CodSeccionPorAlias
@alias char(10)
as 
Select cod_seccion from seccion where des_alias=@alias and cod_publicacion=53


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE  procedure IAR_sp_P21ListColumnasAnt
@codseccion int
as 
Select top 60 cod_nota, des_titulonota, fec_registro from notas where cod_seccion=@codseccion
 order by fec_registro desc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create  procedure IAR_sp_P21ListDirector

as 
Select cod_nota, des_titulonota, fec_registro from notas where cod_seccion=402 and fec_registro >'09/01/2006' order by fec_Registro desc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE             procedure grabanota

	@varseccion int,
	@vartitulo char(1000), 
   	@varcabecera char(2000),
	@varvolada char(500),
	--@vartexto varchar(5000),
	@vartexto text,
	@vnomimage char(500),
	@varautor  char(150),
	@varRank int,
	@varPagina char(30),
	@varcreditofoto varchar(50),
	@varsumilla varchar(500),
	@fec_registro varchar(19)
	--@varCodNota as numeric output
as
BEGIN
BEGIN TRAN
declare @varcodpublicacion int,
	@varcodPlantilla int,
	@codnota int,
	@codfoto int,
	@imagen varchar(30),
	@pos int,
	@varCodNota as numeric
	

select	@varcodpublicacion = cod_publicacion,
	@varcodPlantilla=cod_plantilladefectonota 
from	seccion 
where	cod_seccion=@varseccion

insert into notas 
(
	cod_publicacion,
	cod_usuario,	
	cod_seccion,
	cod_plantilla,
	des_titulonota,
	des_cabecera,
	des_volada,
	des_texto,
	des_autor,
	num_prioridad,
	des_pagina,
	fec_registro
)
values 
(
	@varcodpublicacion,
	99,	
	@varseccion,
	@varcodPlantilla,
	@vartitulo,
	@varcabecera,
	@varvolada,
	@vartexto,
	@varautor,
	@varRank,
	@varPagina,
	convert(datetime,@fec_registro,103)

)

select @codnota = @@identity from notas
SET @varCodNota=@codnota
--inserta un registro en fotos y foto nota por cada foto enviada

set @vnomimage = ltrim(rtrim(@vnomimage))+ ','
set @pos = charindex(',', @vnomimage, 1)

	if replace(@vnomimage, ',', '') <> ''
	begin
		while @pos > 0
		begin
			set @imagen = ltrim(rtrim(left(@vnomimage, @pos - 1)))
			if @imagen <> ''
			begin
				insert into foto 
				(
					cod_publicacion, 
					des_nombrearchivo,
					des_autor,	
					fec_registro
				)
				values 
				(	
					@varcodpublicacion,
					@imagen,
					@varcreditofoto,
					convert(datetime,@fec_registro,103)
					--getdate()
				)
				
				select @codfoto = @@identity from foto

				insert fotonota 
				(
					cod_nota, 
					cod_foto,
					des_sumillafoto, 
					num_prioridad,
					fec_registro
				)
				values 
				(
					@codnota, 
					@codfoto,
					@varsumilla,
					0,
					convert(datetime,@fec_registro,103)
					--getdate()
				)
			end
			set @vnomimage= right(ltrim(rtrim(@vnomimage)),len(@vnomimage) - @pos)
			set @pos = charindex(',', @vnomimage, 1)
		end
	end

insert into notas_pdf 
(
	cod_nota,
	cod_seccion,
	cod_publicacion,
	des_titulonota, 
	des_cabecera, 
	des_texto, 
	des_autor,
	des_textoauxiliar,
	des_pagina
)
values 
(
	@codnota,
	@varseccion,
	@varcodpublicacion,
	@vartitulo,
	@varcabecera,
	@vartexto,
	@varautor,
	@varvolada,
	@varPagina
)
SELECT @varCodNota AS 'Cod_Nota',@varcodpublicacion as 'Cod_Publicacion'
--set @varCodNota=@codnota

IF @@ERROR = 0
COMMIT TRANSACTION 
ELSE
ROLLBACK TRANSACTION 
END







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO








CREATE        procedure grabanota1

	@varseccion int,
	@vartitulo char(1000), 
   	@varcabecera char(2000),
	@varvolada char(500),
	--@vartexto varchar(5000),
	@vartexto text,
	@vnomimage char(500),
	@varautor  char(150),
	@varRank int,
	@varPagina char(30),
	@varcreditofoto varchar(50),
	@varsumilla varchar(500)
	--@varCodNota as numeric output
as
BEGIN
BEGIN TRAN
declare @varcodpublicacion int,
	@varcodPlantilla int,
	@codnota int,
	@codfoto int,
	@imagen varchar(30),
	@pos int,
	@varCodNota as numeric
	

select	@varcodpublicacion = cod_publicacion,
	@varcodPlantilla=cod_plantilladefectonota 
from	seccion 
where	cod_seccion=@varseccion

insert into notas 
(
	cod_publicacion,
	cod_seccion,
	cod_plantilla,
	des_titulonota,
	des_cabecera,
	des_volada,
	des_texto,
	des_autor,
	num_prioridad,
	des_pagina
)
values 
(
	@varcodpublicacion,
	@varseccion,
	@varcodPlantilla,
	@vartitulo,
	@varcabecera,
	@varvolada,
	@vartexto,
	@varautor,
	@varRank,
	@varPagina
)

select @codnota = @@identity from notas
SET @varCodNota=@codnota
--inserta un registro en fotos y foto nota por cada foto enviada

set @vnomimage = ltrim(rtrim(@vnomimage))+ ','
set @pos = charindex(',', @vnomimage, 1)

	if replace(@vnomimage, ',', '') <> ''
	begin
		while @pos > 0
		begin
			set @imagen = ltrim(rtrim(left(@vnomimage, @pos - 1)))
			if @imagen <> ''
			begin
				insert into foto 
				(
					cod_publicacion, 
					des_nombrearchivo,
					des_autor,	
					fec_registro
				)
				values 
				(	
					@varcodpublicacion,
					@imagen,
					@varcreditofoto,
					getdate()
				)
				
				select @codfoto = @@identity from foto

				insert fotonota 
				(
					cod_nota, 
					cod_foto,
					des_sumillafoto, 
					num_prioridad,
					fec_registro
				)
				values 
				(
					@codnota, 
					@codfoto,
					@varsumilla,
					0,
					getdate()
				)
			end
			set @vnomimage= right(ltrim(rtrim(@vnomimage)),len(@vnomimage) - @pos)
			set @pos = charindex(',', @vnomimage, 1)
		end
	end

insert into notas_pdf 
(
	cod_nota,
	cod_seccion,
	cod_publicacion,
	des_titulonota, 
	des_cabecera, 
	des_texto, 
	des_autor,
	des_textoauxiliar,
	des_pagina
)
values 
(
	@codnota,
	@varseccion,
	@varcodpublicacion,
	@vartitulo,
	@varcabecera,
	@vartexto,
	@varautor,
	@varvolada,
	@varPagina
)
SELECT @varCodNota AS 'Cod_Nota',@varcodpublicacion as 'Cod_Publicacion'
--set @varCodNota=@codnota

IF @@ERROR = 0
COMMIT TRANSACTION 
ELSE
ROLLBACK TRANSACTION 
END






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/****** Objeto:  procedimiento almacenado dbo.grabanota    fecha de la secuencia de comandos: 02/08/2007 05:29:34 a.m. ******/
CREATE    procedure grabanota
	@varseccion int,
	@vartitulo char(1000), 
   	@varcabecera char(2000),
	@varvolada char(500),
	@vartexto text,
	@vnomimage char(500),
	@varautor  char(150),
	@varRank int,
	@varPagina char(30)
as
declare @varcodpublicacion int,
	@varcodPlantilla int,
	@codnota int,
	@codfoto int,
	@imagen varchar(30),
	@pos int
select @varcodpublicacion = cod_publicacion,@varcodPlantilla=cod_plantilladefectonota from seccion where cod_seccion=@varseccion
insert into notas (cod_publicacion, cod_seccion, cod_plantilla,des_titulonota, des_cabecera, des_volada,des_texto, des_autor,num_prioridad,des_pagina)
values (@varcodpublicacion,@varseccion,@varcodPlantilla,@vartitulo,@varcabecera,@varvolada,@vartexto,@varautor,@varRank,@varPagina)
select @codnota = @@identity from notas
--inserta un registro en fotos y foto nota por cada foto enviada
set @vnomimage = ltrim(rtrim(@vnomimage))+ ','
set @pos = charindex(',', @vnomimage, 1)
	if replace(@vnomimage, ',', '') <> ''
	begin
		while @pos > 0
		begin
			set @imagen = ltrim(rtrim(left(@vnomimage, @pos - 1)))
			if @imagen <> ''
			begin
				insert into foto (cod_publicacion, des_nombrearchivo,fec_registro)
				values (@varcodpublicacion,@imagen,getdate() )
				
				select @codfoto = @@identity from foto
				insert fotonota (cod_nota, cod_foto, num_prioridad,fec_registro)
				values (@codnota, @codfoto,0,getdate())
			end
			set @vnomimage= right(ltrim(rtrim(@vnomimage)),len(@vnomimage) - @pos)
			set @pos = charindex(',', @vnomimage, 1)
		end
	end



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

CREATE procedure grabanota

	@varseccion int,
	@vartitulo char(500), 
    @varcabecera char(2000),
	@vartexto text,
	@vnomimage char(500),
	@varautor  char(100),
	@varRank int
as
declare @varcodpublicacion int,
	@varcodPlantilla int,
	@codnota int,
	@codfoto int,
	@imagen varchar(30),
	@pos int

select @varcodpublicacion = cod_publicacion,@varcodPlantilla=cod_plantilladefectonota from seccion where cod_seccion=@varseccion

insert into notas (cod_publicacion, cod_seccion, cod_plantilla,des_titulonota, des_cabecera, des_texto, des_autor,num_prioridad)
values (@varcodpublicacion,@varseccion,@varcodPlantilla,@vartitulo,@varcabecera,@vartexto,@varautor,@varRank)

select @codnota = @@identity from notas
--inserta un registro en fotos y foto nota por cada foto enviada

set @vnomimage = ltrim(rtrim(@vnomimage))+ ','
set @pos = charindex(',', @vnomimage, 1)

	if replace(@vnomimage, ',', '') <> ''
	begin
		while @pos > 0
		begin
			set @imagen = ltrim(rtrim(left(@vnomimage, @pos - 1)))
			if @imagen <> ''
			begin
				insert into foto (cod_publicacion, des_nombrearchivo,fec_registro)
				values (@varcodpublicacion,@imagen,getdate() )
				
				select @codfoto = @@identity from foto

				insert fotonota (cod_nota, cod_foto, num_prioridad,fec_registro)
				values (@codnota, @codfoto,0,getdate())
			end
			set @vnomimage= right(ltrim(rtrim(@vnomimage)),len(@vnomimage) - @pos)
			set @pos = charindex(',', @vnomimage, 1)
		end
	end
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*=================================================================*/
Create Procedure spCo_ApruebaNotaComentario
	@pid_NotaComenta int,
	@pcUsuCod varchar(15)
As

	Begin Tran

	Update NotaComenta Set 
		bEstApr = 1,
		cUsuMod = @pcUsuCod,
		sdFecMod = getdate(),
		vHost = host_name()
	Where id_NotaComenta = @pid_NotaComenta

	If @@error = 0
		Commit
	Else
		Rollback


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*=================================================================*/
Create Procedure spCo_ConsultaNotaComentario
	@pid_NotaComenta int 
As

	Select id_NotaComenta, vTitulo, vComentario, vAutor, vEmail, 
	convert(char(10),sdFecCre,103) as sdFecCre, bEstNot, bEstApr 
	From NotaComenta 
	Where id_NotaComenta = @pid_NotaComenta

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*=================================================================*/
Create Procedure spCo_EliminaNotaComentario
	@pid_NotaComenta int,
	@pcUsuCod varchar(15)
As

	Begin Tran

	Update NotaComenta Set 
		bEstNot = 0,
		cUsuEli = @pcUsuCod,
		sdFecEli = getdate(),
		vHost = host_name()
	Where id_NotaComenta = @pid_NotaComenta

	If @@error = 0
		Commit
	Else
		Rollback


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

Create Procedure spCo_InsertaNotaComentario
	@pcod_Nota int,
	@pid_TipEdi tinyint,
	@pvTitulo	varchar(25),
	@pvComentario varchar(2000),
	@pvAutor varchar(60),
	@pvEmail varchar(45)
As

	Begin Tran

	Insert NotaComenta(cod_Nota, id_TipEdi, vTitulo, vComentario, vAutor, vEmail)
	Values (@pcod_Nota, @pid_TipEdi, @pvTitulo, @pvComentario, @pvAutor, @pvEmail)

	If @@error = 0
		Commit
	Else
		Rollback


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE Procedure spCo_ListadoNotaComentario
	@pcod_Nota int, 
	@pbEstNot bit,
	@pbEstApr bit
As

	Select id_NotaComenta, vTitulo, vComentario, vAutor, vEmail, 
	convert(char(10),sdFecCre,103) as sdFecCre, bEstNot, bEstApr 
	From NotaComenta 
	Where cod_Nota = @pcod_Nota And 
	bEstNot In (1, @pbEstNot) And
	bEstApr In (0, @pbEstApr)
	Order by sdFecCre Desc


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*=================================================================*/
Create Procedure spCo_ListadoNotaComentarioTop
As
	/* Lista los 10 top de Notas */
	Select top 10 a.cod_Nota, a.des_tituloNota, convert(char(10), 
	a.fec_Registro,103) as fec_Registro, b.Cant
	From Notas a Inner Join 
	(Select Cod_Nota, Count(*)as Cant 
	 From NotaComenta Where bEstNot = 1 And bEstApr In (0) Group By Cod_Nota)b
	On a.cod_nota = b.cod_Nota
	Where a.est_activo = 1 And b.Cant>0
	Order by a.fec_Registro Desc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*=================================================================*/
Create Procedure spCo_ModificaNotaComentario
	@pid_NotaComenta int,
	@pvTitulo	varchar(25),
	@pvComentario varchar(2000),
	@pvAutor varchar(60),
	@pvEmail varchar(45),
	@pvbAct bit,
	@pvbApr bit,
	@pcUsuCod varchar(15)
As

	Begin Tran

	Update NotaComenta Set 
		vTitulo = @pvTitulo,
		vComentario = @pvComentario,
		vAutor = @pvAutor,
		vEmail = @pvEmail,
		bEstNot = @pvbAct,
		bEstApr = @pvbApr,
		cUsuMod = @pcUsuCod,
		sdFecMod = getdate(),
		vHost = host_name()
	Where id_NotaComenta = @pid_NotaComenta

	If @@error = 0
		Commit
	Else
		Rollback


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO






CREATE      Procedure spGe_NotasConsultarXml
As

	Set Nocount on

	Declare @Not Table 
	(
		cod_Nota int Primary Key, 
		nom_seccion Char(50) COLLATE SQL_Latin1_General_CP850_CI_AI NULL,
		des_tituloNota Char(500) COLLATE SQL_Latin1_General_CP850_CI_AI NULL,
		des_cabecera VarChar(2000) COLLATE SQL_Latin1_General_CP850_CI_AI NULL,
		des_texto	Text COLLATE SQL_Latin1_General_CP850_CI_AI NULL,
		des_autor Char(100) COLLATE SQL_Latin1_General_CP850_CI_AI NULL,
		fec_Registro smalldatetime
	)

	Declare @vFecIni char(10), @vFecFin char(10)
	set @vFecIni = convert(char(10),getdate()-1,103)
	set @vFecFin = convert(char(10),getdate()-1,103)
/*	
	Select cod_seccion, cod_Plantilla, Nom_seccion 
	Into #Sec
	From Seccion Where est_Activo = 1 And cod_publicacion = 59
*/	
	Insert Into @Not
	Select n.cod_Nota, s.nom_seccion, n.des_tituloNota, n.des_cabecera, n.des_texto, 
	Case when rtrim(n.des_autor) = '' then 'ecw' else n.des_autor end as des_autor, 
	n.fec_Registro
	From notas n inner join seccion s On n.cod_seccion = s.cod_seccion
	Where n.est_activo = 1 And n.est_archivo= 0 And
	--n.cod_publicacion = 59 And 
	n.fec_Registro >= convert(smalldatetime, @vFecIni + ' 00:00', 103) and
	n.fec_Registro <= convert(smalldatetime, @vFecFin + ' 23:59', 103) and
--	n.cod_seccion in (Select cod_seccion From #sec)
	s.est_Activo = 1 And s.cod_publicacion in (59)
	Order By n.cod_nota

	Select cod_Nota, nom_seccion, des_tituloNota, des_cabecera, des_texto, des_autor, fec_Registro
	From @Not






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

Create Procedure spGe_NotasFotoConsultarXml
As

	Set Nocount on
	
	Declare @Not Table 
	(
		cod_Nota int Primary Key, 
		des_tituloNota VarChar(500),
		des_cabecera VarChar(2000),
		des_volada VarChar(2000),
		des_texto	Text
	)

	Select cod_seccion, cod_Plantilla, Nom_seccion 
	Into #Sec
	From Seccion Where est_Activo = 1 And cod_publicacion = 59
	
	Insert Into @Not
	Select cod_Nota,  des_tituloNota, des_cabecera, des_volada, des_texto
	From notas Where est_archivo= 0 And 
	cod_publicacion = 59 And fec_Registro >= (getdate()-1) And
	cod_seccion in (Select cod_seccion From #sec)
	Order By cod_nota

	Select cod_Nota, cod_Foto, des_SumillaFoto  from FotoNota
	where cod_Nota in (Select cod_nota from @Not)
	Order by cod_nota, num_prioridad 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE dbo.sp_ActualizaCuerpo
@ID_Cuerpo int,
@Cod_Cuerpo varchaR(2),
@Cod_Estado char(1)
AS
update CUERPO 
set Cod_Cuerpo=@Cod_Cuerpo,
    Cod_Estado=@Cod_Estado
where ID_Cuerpo=@ID_Cuerpo 	


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE dbo.sp_ActualizaCuerpoFolio
@iID_CuerpoFolio numeric,
@iID_Cuerpo int,
@iID_Folio int,
@iID_Seccion smallint
AS
UPDATE cuerpofolio
SET ID_Cuerpo=@iID_Cuerpo,
    ID_Folio=@iID_Folio,
    ID_Seccion=@iID_Seccion
WHERE ID_CuerpoFolio=@iID_CuerpoFolio


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE       PROCEDURE dbo.sp_ActualizaEstadoArchivoNotas
@fec_registro varchar(10)
AS
declare
@iDia smallint
set @iDia =(SELECT DATEPART(dw, GETDATE()))

/*update	notas 
set	est_archivo='0',
	est_activo='1' 
where	convert(char(10),fec_registro,103)<>convert(char(10),@fec_registro,103) and
	cod_seccion in (426,436,432,428,435,430,429,431,427,424,425,540,435,437,723,485) AND
	est_archivo='1' --and
	--Nuevo
	--est_activo='1'

*/
update	notas 
set	est_archivo='0',
	est_activo='1' 
where	convert(char(10),fec_registro,103)<>convert(char(10),@fec_registro,103) and
	cod_seccion in (426,436,432,428,435,430,429,431,427,424,425,540,435,723,485) AND 
	est_archivo='1'
--##########################Para el caso del dominical#####################
--Solo se actualiza el día domingo por la noche
if @iDia=1 and CONVERT(CHAR(5), GETDATE(), 108) >= '18:30' 
begin
update	notas 
set	est_archivo='0',
	est_activo='1' 
where	cod_seccion = 437
	AND est_archivo='1'
end
--##########################Fin#############################################



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE procedure DBO.sp_ActualizaEstadoGeneracion
@sEstgenerado char(1)
AS
update publicacion set est_generado=@sEstgenerado  where cod_publicacion=59

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE  PROCEDURE dbo.sp_ActualizaFolio
@codigo int,
@cod_folio varchar(4),
@nom_folio varchar(20)
As
Update Folios
  set cod_folio=@cod_folio,
      nom_folio=@nom_folio
Where ID_Folio=@codigo


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE  PROCEDURE DBO.sp_ActualizaSuplemento
AS
SET NOCOUNT ON
DECLARE
@codigo INT,
@des_pagina varchar(50),
@Secciones varchar(50),
@est_seccion CHAR(1),
@est_suplemento CHAR(1),
@TempSecciones varchar(50),
@iContador integer,
@iContadorLuces integer,
@iContadorDeporte integer,
@iDia smallint,
@sRutaPagina varchar(200),
@sNombreLuces varchar(10),
@sFechaDominical varchar(10),
@des_pagina_domi varchar(50),
@iContador_Hogar integer,
@iContador_Minegocio integer

DECLARE
@TablaTemporal
TABLE 
(
	codigo INT,
	des_pagina varchar(50),
	Secciones varchar(50),
	est_seccion CHAR(1),
	est_suplemento CHAR(1)
)

set @iContador_Minegocio=0
set @iContador_Hogar=0
set @iContador=0
set @iContadorLuces =0
set @iContadorDeporte=0
set @iDia =(SELECT DATEPART(dw, GETDATE()))
set @sRutaPagina='/edicionimpresa/Html/'

/*INSERT INTO @TablaTemporal 
SELECT	codigo,NombreArchivo,Secciones,est_seccion,est_suplemento  
--from	ivmakernew..tempGeneraImpresa 
from	ivmakernew..TempGeneraEdicionImpresa
WHERE	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),11,1))<>'G' AND
	flagPDF='1'
ORDER BY 1
INSERT INTO @TablaTemporal 
SELECT	codigo,NombreArchivo,Secciones,est_seccion,est_suplemento 
--from	ivmakernew..tempGeneraImpresa 
from	ivmakernew..TempGeneraEdicionImpresa
WHERE	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),11,1))='G' AND 
	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),3,2))='DT' AND
	flagPDF='1'
GROUP BY codigo,NombreArchivo,Secciones,est_seccion,est_suplemento 
ORDER BY 1
INSERT INTO @TablaTemporal 
SELECT	codigo,NombreArchivo,Secciones,est_seccion,est_suplemento 
--from	ivmakernew..tempGeneraImpresa 
from	ivmakernew..TempGeneraEdicionImpresa
WHERE	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),11,1))='G' AND
	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),3,2))<>'DT'AND
	flagPDF='1'  
GROUP BY SUBSTRING(LTRIM(NOMBREARCHIVO),3,2) ,codigo,NombreArchivo,Secciones,est_seccion,est_suplemento 
ORDER BY SUBSTRING(LTRIM(NOMBREARCHIVO),3,2) DESC
*/

INSERT INTO @TablaTemporal 
SELECT	codigo,NombreArchivo,Secciones,est_seccion,est_suplemento  
--from	ivmakernew..tempGeneraImpresa 
from	ivmakernew..TempGeneraEdicionImpresa
WHERE	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),11,1))<>'G' AND
	flagPDF='1'
ORDER BY 1

INSERT INTO @TablaTemporal 
SELECT	codigo,NombreArchivo,Secciones,est_seccion,est_suplemento 
from	ivmakernew..TempGeneraEdicionImpresa
WHERE	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),11,1))='G' AND 
	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),3,2))='PR' AND
	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),12,1))='1' AND
	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),13,1))='.' AND
	flagPDF='1'
GROUP BY codigo,NombreArchivo,Secciones,est_seccion,est_suplemento 
ORDER BY 1

INSERT INTO @TablaTemporal 
SELECT	codigo,NombreArchivo,Secciones,est_seccion,est_suplemento 
from	ivmakernew..TempGeneraEdicionImpresa
WHERE	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),11,1))='G' AND 
	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),3,2))='DT' AND
	flagPDF='1'
GROUP BY codigo,NombreArchivo,Secciones,est_seccion,est_suplemento 
ORDER BY 1

INSERT INTO @TablaTemporal 
SELECT	codigo,NombreArchivo,Secciones,est_seccion,est_suplemento 
from	ivmakernew..TempGeneraEdicionImpresa
WHERE	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),11,1))='G' AND
	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),3,2))<>'DT'AND
	flagPDF='1' AND
 	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),3,2))<>'PR'
GROUP BY SUBSTRING(LTRIM(NOMBREARCHIVO),3,2) ,codigo,NombreArchivo,Secciones,est_seccion,est_suplemento 
ORDER BY SUBSTRING(LTRIM(NOMBREARCHIVO),3,2) DESC
--select * from @TablaTemporal

DECLARE	CURSOR_SUPLEMENTO CURSOR FOR SELECT * FROM @TablaTemporal
OPEN	CURSOR_SUPLEMENTO 
FETCH	NEXT FROM CURSOR_SUPLEMENTO INTO @codigo,@des_pagina,@Secciones,@est_seccion,@est_suplemento
WHILE 	@@FETCH_STATUS = 0
BEGIN
	if @iDia=1 --Domingo
	begin
	   --print @iDia+'-'+@Secciones+'-'+@iContador
           --if ltrim(rtrim(@Secciones))='casas' and @iContador=0
           --if ltrim(rtrim(@Secciones))='hogar' and @iContador=0
	   if ltrim(rtrim(@Secciones))='hogar' and @iContador_Hogar=0
	   begin
		 -- print substring(ltrim(rtrim(@des_pagina)),1,len(ltrim(rtrim(@des_pagina)))-4)
		 update	Suplemento 
		 set	des_pagina=REPLACE(ltrim(rtrim(@des_pagina)),'.pdf',''),
			fec_registro='20' + substring(ltrim(rtrim(@des_pagina)),9,2)+substring(ltrim(rtrim(@des_pagina)),7,2)+substring(ltrim(rtrim(@des_pagina)),5,2) ,
			ruta_pagina= @sRutaPagina + '20' + substring(ltrim(rtrim(@des_pagina)),9,2) + '-' + substring(ltrim(rtrim(@des_pagina)),7,2) + '-' + substring(ltrim(rtrim(@des_pagina)),5,2)+ '/' + replace(ltrim(rtrim(@des_pagina)),'.pdf','.html'),
			seccion='MI HOGAR'
		 where	nro_dia=1 and id_suplemento=1
		 set @iContador_Hogar=@iContador_Hogar+1	
	   end
	   else	
	   begin
		 -- print substring(ltrim(rtrim(@des_pagina)),1,len(ltrim(rtrim(@des_pagina)))-4)
		 if ltrim(rtrim(@Secciones))='mi negocio' and @iContador_Minegocio=0
		 begin
	
		 update	Suplemento 
		 set	des_pagina=REPLACE(ltrim(rtrim(@des_pagina)),'.pdf',''),
			fec_registro='20' + substring(ltrim(rtrim(@des_pagina)),9,2)+substring(ltrim(rtrim(@des_pagina)),7,2)+substring(ltrim(rtrim(@des_pagina)),5,2) ,
			ruta_pagina= @sRutaPagina + '20' + substring(ltrim(rtrim(@des_pagina)),9,2) + '-' + substring(ltrim(rtrim(@des_pagina)),7,2) + '-' + substring(ltrim(rtrim(@des_pagina)),5,2)+ '/' + replace(ltrim(rtrim(@des_pagina)),'.pdf','.html'),
			seccion='MI NEGOCIO'
		 where	nro_dia=1 and id_suplemento=10
		 set @iContador_Minegocio=@iContador_Minegocio+1
		 end	
	   end
	   --######################DOMINICAL#######################################
	   --Se ejecuta para el dominical
		--set @sFechaDominical = (select top 1 convert(char(10),fec_registro,120) as fecha_url from notas where cod_seccion=437 order by fec_registro desc, num_prioridad asc)	
		--set @des_pagina_domi =dbo.LimpiaHTML((select top 1 substring(des_titulonota,1,30) as des_titulonota from notas where cod_seccion=437 order by fec_registro desc, num_prioridad asc))
		set @sFechaDominical = (select top 1 convert(char(10),fec_registro,120) as fecha_url from notas where cod_seccion=437 and est_activo='1' order by num_prioridad asc,fec_registro desc)	
		--set @des_pagina_domi =dbo.LimpiaHTML((select top 1 substring(des_titulonota,1,30) as des_titulonota from notas where cod_seccion=437 and est_activo='1' order by num_prioridad asc,fec_registro desc))
		set @des_pagina_domi =dbo.LimpiaTituloHTML((select top 1 substring(des_titulonota,1,30) as des_titulonota from notas where cod_seccion=437 and est_activo='1' order by num_prioridad asc,fec_registro desc))


		update	Suplemento 
		set	des_pagina=ltrim(rtrim(@des_pagina_domi)),
			fec_registro=REPLACE(LTRIM(RTRIM(@sFechaDominical)),'-',''),
			ruta_pagina= @sRutaPagina + @sFechaDominical + '/' + ltrim(rtrim(@des_pagina_domi))+ '.html',
			seccion='EL DOMINICAL'
		 where	nro_dia=1 and id_suplemento=11
		 set @iContador=@iContador+1	
	   --######################FIN DOMINICAL################################
	
	end

	if @iDia=2 --Lunes
	begin
           if ltrim(rtrim(@Secciones))='dia uno' and @iContador=0
	   begin
		 -- print substring(ltrim(rtrim(@des_pagina)),1,len(ltrim(rtrim(@des_pagina)))-4)
		 update	Suplemento 
		 set	des_pagina=REPLACE(ltrim(rtrim(@des_pagina)),'.pdf',''),
			fec_registro='20' + substring(ltrim(rtrim(@des_pagina)),9,2)+substring(ltrim(rtrim(@des_pagina)),7,2)+substring(ltrim(rtrim(@des_pagina)),5,2) ,
			ruta_pagina= @sRutaPagina + '20' + substring(ltrim(rtrim(@des_pagina)),9,2) + '-' + substring(ltrim(rtrim(@des_pagina)),7,2) + '-' + substring(ltrim(rtrim(@des_pagina)),5,2)+ '/' + replace(ltrim(rtrim(@des_pagina)),'.pdf','.html'),
			seccion='Día 1'
		 where	nro_dia=2 and id_suplemento=2
		 set @iContador=@iContador+1	
	   end
	end

	if @iDia=3 --Martes
	begin
           if ltrim(rtrim(@Secciones))='vamos' and @iContador=0
	   begin
		 -- print substring(ltrim(rtrim(@des_pagina)),1,len(ltrim(rtrim(@des_pagina)))-4)
		 update	Suplemento 
		 set	des_pagina=REPLACE(ltrim(rtrim(@des_pagina)),'.pdf',''),
			fec_registro='20' + substring(ltrim(rtrim(@des_pagina)),9,2)+substring(ltrim(rtrim(@des_pagina)),7,2)+substring(ltrim(rtrim(@des_pagina)),5,2) ,
			ruta_pagina= @sRutaPagina + '20' + substring(ltrim(rtrim(@des_pagina)),9,2) + '-' + substring(ltrim(rtrim(@des_pagina)),7,2) + '-' + substring(ltrim(rtrim(@des_pagina)),5,2)+ '/' + replace(ltrim(rtrim(@des_pagina)),'.pdf','.html'),
			seccion='¡VAMOS!'
		 where	nro_dia=3 and id_suplemento=3
		 set @iContador=@iContador+1	
	   end
	end
	if @iDia=4 --Miercoles
	begin
           if ltrim(rtrim(@Secciones))='casas' and @iContador=0
	   begin
		 -- print substring(ltrim(rtrim(@des_pagina)),1,len(ltrim(rtrim(@des_pagina)))-4)
		 update	Suplemento 
		 set	des_pagina=REPLACE(ltrim(rtrim(@des_pagina)),'.pdf',''),
			fec_registro='20' + substring(ltrim(rtrim(@des_pagina)),9,2)+substring(ltrim(rtrim(@des_pagina)),7,2)+substring(ltrim(rtrim(@des_pagina)),5,2) ,
			ruta_pagina= @sRutaPagina + '20' + substring(ltrim(rtrim(@des_pagina)),9,2) + '-' + substring(ltrim(rtrim(@des_pagina)),7,2) + '-' + substring(ltrim(rtrim(@des_pagina)),5,2)+ '/' + replace(ltrim(rtrim(@des_pagina)),'.pdf','.html'),
			seccion='CASA Y MÁS'
		 where	nro_dia=4 and id_suplemento=4
		 set @iContador=@iContador+1	
	   end
	end
	--Para Luces
        if @iDia=6
	BEGIN
	   set @sNombreLuces='¡VIERNES!'	 	
	END
	else
	BEGIN
	   set @sNombreLuces='LUCES' 
	END

        if ltrim(rtrim(@Secciones))='luces' and @iContadorLuces=0
	Begin
		 update	Suplemento 
		 set	des_pagina=replace(ltrim(rtrim(@des_pagina)),'.pdf',''),
			fec_registro='20' + substring(ltrim(rtrim(@des_pagina)),9,2)+substring(ltrim(rtrim(@des_pagina)),7,2)+substring(ltrim(rtrim(@des_pagina)),5,2) ,
			ruta_pagina= @sRutaPagina + '20' + substring(ltrim(rtrim(@des_pagina)),9,2) + '-' + substring(ltrim(rtrim(@des_pagina)),7,2) + '-' + substring(ltrim(rtrim(@des_pagina)),5,2)+ '/' + replace(ltrim(rtrim(@des_pagina)),'.pdf','.html'),
			seccion=@sNombreLuces
		 where	nro_dia=8 and id_suplemento=8
		 set @iContadorLuces=@iContadorLuces+1	
	end	

        if ltrim(rtrim(@Secciones))='deporte' and @iContadorDeporte=0
	Begin
		 update	Suplemento 
		 set	des_pagina=replace(ltrim(rtrim(@des_pagina)),'.pdf',''),
			fec_registro='20' + substring(ltrim(rtrim(@des_pagina)),9,2)+substring(ltrim(rtrim(@des_pagina)),7,2)+substring(ltrim(rtrim(@des_pagina)),5,2) ,
			ruta_pagina= @sRutaPagina + '20' + substring(ltrim(rtrim(@des_pagina)),9,2) + '-' + substring(ltrim(rtrim(@des_pagina)),7,2) + '-' + substring(ltrim(rtrim(@des_pagina)),5,2)+ '/' + replace(ltrim(rtrim(@des_pagina)),'.pdf','.html'),
			seccion='DEPORTE TOTAL'
		 where	nro_dia=9 and id_suplemento=9
		 set @iContadorDeporte=@iContadorDeporte+1	
	end
FETCH	NEXT FROM CURSOR_SUPLEMENTO INTO @codigo,@des_pagina,@Secciones,@est_seccion,@est_suplemento
END
CLOSE CURSOR_SUPLEMENTO
DEALLOCATE CURSOR_SUPLEMENTO
--SELECT * FROM Suplemento where est_registro='1' order by prioridad




SET QUOTED_IDENTIFIER ON








GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sp_EliminaArchivosXAsignar
@NombreArchivo varchar(100)
As
Delete from ArchivosXAsignar where ltrim(rtrim(NombreArchivo))=@NombreArchivo


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE dbo.sp_EliminaCuerpoFolio
@ID_CuerpoFolio numeric
AS
DELETE FROM CUERPOFOLIO WHERE ID_CuerpoFolio=@ID_CuerpoFolio


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE sp_EliminaPaginasErradas
@sSeccionID varchar(50)
AS
delete from paginaserradas where SeccionID=@sSeccionID


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


/*Procedimiento que se encarga de eliminar los registros
  de la tabla ArchivosXAsignar esta es una tabla temporar
  y solo se usara para reprocesar los archvios que no han 
  sido enviados a una seccion correspondiente
  Este procedimiento se debe de ejecutar todos los dias a 
  las 10 am
*/
CREATE procedure sp_EliminarRegistrosArchivosXAsignar
AS
delete from ArchivosXAsignar

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.sp_ExisteCuerpoFolio
@ID_Cuerpo int,
@ID_Folio int,
@ID_Seccion int
AS
Declare @Reg int
set @Reg=(select count(*) from cuerpofolio where ID_Cuerpo=@ID_Cuerpo and ID_Folio=@ID_Folio and ID_Seccion=@ID_Seccion)
select @Reg as Registro

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sp_GeneraIndices
AS
SET NOCOUNT ON
DECLARE
@TablaTemporal
TABLE 
(
	Cod_Seccion INT,
	Cod_Plantilla INT,
	Des_alias VARCHAR(20),
	Des_archivoplantilla VARCHAR(25),
	Des_rutaVirtual VARCHAR(50)
)

declare
@iCod_Seccion INT,@iCod_Plantilla INT, @sDes_alias as varchar(20),
@sdes_archivoplantilla varchar(25), @sdes_rutaVirtual as varchar(50)

DECLARE	CURSOR_EMPRESAS CURSOR FOR
select cod_seccion,cod_plantilla,des_alias 
from seccion 
where cod_seccion in (424,425,426,427,428,429,430,431,432,433,434,435,436,437,440,442,457,467,509,544)
order by 1
OPEN	CURSOR_EMPRESAS 
FETCH	NEXT FROM CURSOR_EMPRESAS INTO @iCod_Seccion, @iCod_Plantilla,@sDes_alias
WHILE 	@@FETCH_STATUS = 0
BEGIN
	SET @sdes_archivoplantilla =(SELECT des_archivoplantilla FROM plantillas WHERE cod_plantilla=@iCod_Plantilla)
	SET @sdes_rutaVirtual=(SELECT a.des_rutavirtual FROM publicacion a, seccion b WHERE b.cod_seccion=@iCod_Seccion AND b.cod_publicacion=a.cod_publicacion)	

	/**********INSERTANDO LOS DATOS EN LA TABLA TEMPORAL**********/
	INSERT INTO @TablaTemporal VALUES(@iCod_Seccion,@iCod_Plantilla,ISNULL(@sDes_alias,''),ISNULL(@sdes_archivoplantilla,''),ISNULL(@sdes_rutaVirtual,''))
	/**************************************************************/
FETCH	NEXT FROM CURSOR_EMPRESAS INTO @iCod_Seccion, @iCod_Plantilla,@sDes_alias
END
CLOSE CURSOR_EMPRESAS 
DEALLOCATE CURSOR_EMPRESAS 
SELECT * FROM @TablaTemporal




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



create  PROCEDURE sp_GeneraIndices1
AS
SET NOCOUNT ON
DECLARE
@TablaTemporal
TABLE 
(
	Cod_Seccion INT,
	Cod_Plantilla INT,
	Des_alias VARCHAR(20),
	Des_archivoplantilla VARCHAR(25),
	Des_rutaVirtual VARCHAR(50)
)

declare
@iCod_Seccion INT,@iCod_Plantilla INT, @sDes_alias as varchar(20),
@sdes_archivoplantilla varchar(25), @sdes_rutaVirtual as varchar(50)

DECLARE	CURSOR_EMPRESAS CURSOR FOR
select cod_seccion,cod_plantilla,des_alias 
from seccion1 
where cod_seccion in (424,425,426,427,428,429,430,431,432,433,434,435,436,437,440,442,457,467,509,544)
order by 1
OPEN	CURSOR_EMPRESAS 
FETCH	NEXT FROM CURSOR_EMPRESAS INTO @iCod_Seccion, @iCod_Plantilla,@sDes_alias
WHILE 	@@FETCH_STATUS = 0
BEGIN
	SET @sdes_archivoplantilla =(SELECT des_archivoplantilla FROM plantillas WHERE cod_plantilla=@iCod_Plantilla)
	SET @sdes_rutaVirtual=(SELECT a.des_rutavirtual FROM publicacion a, seccion1 b WHERE b.cod_seccion=@iCod_Seccion AND b.cod_publicacion=a.cod_publicacion)	

	/**********INSERTANDO LOS DATOS EN LA TABLA TEMPORAL**********/
	INSERT INTO @TablaTemporal VALUES(@iCod_Seccion,@iCod_Plantilla,ISNULL(@sDes_alias,''),ISNULL(@sdes_archivoplantilla,''),ISNULL(@sdes_rutaVirtual,''))
	/**************************************************************/
FETCH	NEXT FROM CURSOR_EMPRESAS INTO @iCod_Seccion, @iCod_Plantilla,@sDes_alias
END
CLOSE CURSOR_EMPRESAS 
DEALLOCATE CURSOR_EMPRESAS 
SELECT * FROM @TablaTemporal





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


/*************************************************************/
/* Procedimiento que selecciona los reistros para generar el  */	
/* el archivo XML para la edicion impresa		     */
/* Nombre : sp_GenerarEdicionImpresaXML			     */
/* Parametro : @sFecha de la nota			     */
/*	     : @iCodSeccion codigo se seccion de la nota     */
/* Condiciones : Se puede generar el archivo en base a la    */
/* de la nota o tambien al base a la fecha y al codigo	     */
/* de la nota 						     */
/* Fecha Creacion : 03 de Marzo 2008 			     */
/* Autor : AAO						     */
/*							     */
/*************************************************************/
CREATE  PROCEDURE dbo.sp_GenerarEdicionImpresaXML
@sFecha char(10)='',
@iCodSeccion int = 0,
@sCuerpo char(1)=''
AS
if @sFecha<>'' and @iCodSeccion=0 AND @sCuerpo=''
begin
	select	n.cod_seccion,s.nom_seccion,n.cod_nota,ltrim(rtrim(n.des_titulonota)),
		--des_cabecera,des_volada,des_texto,des_autor,
		ltrim(rtrim(n.des_cabecera)),ltrim(rtrim(n.des_volada)),ltrim(rtrim(n.des_autor)),
		n.num_prioridad,n.fec_registro,ltrim(rtrim(n.des_pagina))
	from	notas n,seccion s 
	where	convert(char(10),n.fec_registro,111)=@sFecha and 
		n.cod_publicacion=59 and
		n.cod_seccion = s.cod_seccion
	group by n.cod_seccion,s.nom_seccion,n.cod_nota,n.des_titulonota,
		n.des_cabecera,n.des_volada,n.des_autor,
		n.num_prioridad,n.fec_registro,n.des_pagina 
	order by n.cod_seccion asc,n.num_prioridad asc
end
if @sFecha<>'' and @iCodSeccion<>0 AND @sCuerpo=''
begin
	select	n.cod_seccion,s.nom_seccion,n.cod_nota,ltrim(rtrim(n.des_titulonota)),
		--des_cabecera,des_volada,des_texto,des_autor,
		ltrim(rtrim(n.des_cabecera)),ltrim(rtrim(n.des_volada)),ltrim(rtrim(n.des_autor)),
		n.num_prioridad,n.fec_registro,ltrim(rtrim(n.des_pagina))
	from	notas n,seccion s 
	where	convert(char(10),n.fec_registro,111)=@sFecha and 
		n.cod_seccion = @iCodSeccion	and				
		n.cod_publicacion=59 and
		n.cod_seccion = s.cod_seccion
	group by n.cod_seccion,s.nom_seccion,n.cod_nota,n.des_titulonota,
		n.des_cabecera,n.des_volada,n.des_autor,
		n.num_prioridad,n.fec_registro,n.des_pagina 
	order by n.cod_seccion asc,n.num_prioridad asc
end
if @sFecha<>'' and @iCodSeccion=0 and @sCuerpo<>''
begin
	select	n.cod_seccion,s.nom_seccion,n.cod_nota,ltrim(rtrim(n.des_titulonota)),
		--des_cabecera,des_volada,des_texto,des_autor,
		ltrim(rtrim(n.des_cabecera)),ltrim(rtrim(n.des_volada)),ltrim(rtrim(n.des_autor)),
		n.num_prioridad,n.fec_registro,ltrim(rtrim(n.des_pagina))
	from	notas n,seccion s 
	where	convert(char(10),n.fec_registro,111)=@sFecha and 
		UPPER(SUBSTRING(LTRIM(RTRIM(n.des_pagina)),11,1))=UPPER(@sCuerpo) AND
		n.des_pagina <>'' AND
		n.cod_publicacion=59 and
		n.cod_seccion = s.cod_seccion
	group by n.cod_seccion,s.nom_seccion,n.cod_nota,n.des_titulonota,
		n.des_cabecera,n.des_volada,n.des_autor,
		n.num_prioridad,n.fec_registro,n.des_pagina 
	order by n.cod_seccion asc,n.num_prioridad asc
end




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





/*************************************************************/
/* Procedimiento que selecciona los reistros para generar el  */	
/* el archivo XML para la edicion impresa		     */
/* Nombre : sp_ImportarEdicionImpresaXML		     */
/* Parametro : @sFecha de la nota			     */
/*	     : @iCodSeccion codigo se seccion de la nota     */
/* Condiciones : Se puede generar el archivo en base a la    */
/* de la nota o tambien al base a la fecha y al codigo	     */
/* de la nota 						     */
/* Fecha Creacion : 03 de Marzo 2008 			     */
/* Autor : AAO						     */
/*							     */
/*************************************************************/
CREATE   PROCEDURE dbo.sp_ImportarEdicionImpresaXML
@sFecha char(10)='',
@iCodSeccion int = 0,
@sCuerpo char(1)=''
AS

SET NOCOUNT ON

DECLARE
@CodNota INT,
@DesTexto VARCHAR(8000)


DECLARE
@TablaTemporal
TABLE 
(
	CodSeccion INT,
	NomSeccion varchar(100),
	CodNota int,
	DesTituloNota varchar(500),
	DesCcabecera varchar(2000),
	DesVolada varchar(2000),
	DesAutor varchar(100),
	NumPrioridad int,
	FecRegistro datetime,
	DesPagina varchar(30),
	DesTexto text
)


if @sFecha<>'' and @iCodSeccion=0 AND @sCuerpo=''
begin
	/*select	n.cod_seccion,s.nom_seccion,n.cod_nota,ltrim(rtrim(n.des_titulonota)),
		ltrim(rtrim(n.des_cabecera)),ltrim(rtrim(n.des_volada)),ltrim(rtrim(n.des_autor)),
		n.num_prioridad,n.fec_registro,ltrim(rtrim(n.des_pagina))
	from	notas n,seccion s 
	where	convert(char(10),n.fec_registro,111)=@sFecha and 
		n.cod_publicacion=59 and
		n.cod_seccion = s.cod_seccion
	group by n.cod_seccion,s.nom_seccion,n.cod_nota,n.des_titulonota,
		n.des_cabecera,n.des_volada,n.des_autor,
		n.num_prioridad,n.fec_registro,n.des_pagina 
	order by n.cod_seccion asc,n.num_prioridad asc*/

	INSERT INTO @TablaTemporal

	select	n.cod_seccion,s.nom_seccion,n.cod_nota,ltrim(rtrim(n.des_titulonota)),
		ltrim(rtrim(n.des_cabecera)),ltrim(rtrim(n.des_volada)),ltrim(rtrim(n.des_autor)),
		n.num_prioridad,n.fec_registro,ltrim(rtrim(n.des_pagina)),'' as DesTexto
	from	notas n,seccion s 
	where	convert(char(10),n.fec_registro,111)=@sFecha and 
		n.cod_publicacion=59 and
		n.cod_seccion = s.cod_seccion
	group by n.cod_seccion,s.nom_seccion,n.cod_nota,n.des_titulonota,
		n.des_cabecera,n.des_volada,n.des_autor,
		n.num_prioridad,n.fec_registro,n.des_pagina 
	order by n.cod_seccion asc,n.num_prioridad asc

	DECLARE	CURSOR_EDICIONIMPRESA CURSOR FOR SELECT CodNota FROM @TablaTemporal
	OPEN	CURSOR_EDICIONIMPRESA 
	FETCH	NEXT FROM CURSOR_EDICIONIMPRESA INTO @CodNota
	WHILE 	@@FETCH_STATUS = 0
	BEGIN
		select @DesTexto = isnull(des_texto,'') from notas where cod_nota=@CodNota
		UPDATE @TablaTemporal SET DesTexto = @DesTexto WHERE CodNota = @CodNota
	FETCH	NEXT FROM CURSOR_EDICIONIMPRESA INTO @CodNota
	END
	CLOSE CURSOR_EDICIONIMPRESA 
	DEALLOCATE CURSOR_EDICIONIMPRESA 
end
if @sFecha<>'' and @iCodSeccion<>0 AND @sCuerpo=''
begin
	
	INSERT INTO @TablaTemporal
	select	n.cod_seccion,s.nom_seccion,n.cod_nota,ltrim(rtrim(n.des_titulonota)),
		--des_cabecera,des_volada,des_texto,des_autor,
		ltrim(rtrim(n.des_cabecera)),ltrim(rtrim(n.des_volada)),ltrim(rtrim(n.des_autor)),
		n.num_prioridad,n.fec_registro,ltrim(rtrim(n.des_pagina)),'' as DesTexto
	from	notas n,seccion s 
	where	convert(char(10),n.fec_registro,111)=@sFecha and 
		n.cod_seccion = @iCodSeccion	and				
		n.cod_publicacion=59 and
		n.cod_seccion = s.cod_seccion
	group by n.cod_seccion,s.nom_seccion,n.cod_nota,n.des_titulonota,
		n.des_cabecera,n.des_volada,n.des_autor,
		n.num_prioridad,n.fec_registro,n.des_pagina 
	order by n.cod_seccion asc,n.num_prioridad asc

	DECLARE	CURSOR_EDICIONIMPRESA CURSOR FOR SELECT CodNota FROM @TablaTemporal
	OPEN	CURSOR_EDICIONIMPRESA 
	FETCH	NEXT FROM CURSOR_EDICIONIMPRESA INTO @CodNota
	WHILE 	@@FETCH_STATUS = 0
	BEGIN
		select @DesTexto = isnull(des_texto,'') from notas where cod_nota=@CodNota
		UPDATE @TablaTemporal SET DesTexto = @DesTexto WHERE CodNota = @CodNota
	FETCH	NEXT FROM CURSOR_EDICIONIMPRESA INTO @CodNota
	END
	CLOSE CURSOR_EDICIONIMPRESA 
	DEALLOCATE CURSOR_EDICIONIMPRESA 
end
if @sFecha<>'' and @iCodSeccion=0 and @sCuerpo<>''
begin
	INSERT INTO @TablaTemporal
	select	n.cod_seccion,s.nom_seccion,n.cod_nota,ltrim(rtrim(n.des_titulonota)),
		--des_cabecera,des_volada,des_texto,des_autor,
		ltrim(rtrim(n.des_cabecera)),ltrim(rtrim(n.des_volada)),ltrim(rtrim(n.des_autor)),
		n.num_prioridad,n.fec_registro,ltrim(rtrim(n.des_pagina)),'' as DesTexto
	from	notas n,seccion s 
	where	convert(char(10),n.fec_registro,111)=@sFecha and 
		UPPER(SUBSTRING(LTRIM(RTRIM(n.des_pagina)),11,1))=UPPER(@sCuerpo) AND
		n.des_pagina <>'' AND
		n.cod_publicacion=59 and
		n.cod_seccion = s.cod_seccion
	group by n.cod_seccion,s.nom_seccion,n.cod_nota,n.des_titulonota,
		n.des_cabecera,n.des_volada,n.des_autor,
		n.num_prioridad,n.fec_registro,n.des_pagina 
	order by n.cod_seccion asc,n.num_prioridad asc

	DECLARE	CURSOR_EDICIONIMPRESA CURSOR FOR SELECT CodNota FROM @TablaTemporal
	OPEN	CURSOR_EDICIONIMPRESA 
	FETCH	NEXT FROM CURSOR_EDICIONIMPRESA INTO @CodNota
	WHILE 	@@FETCH_STATUS = 0
	BEGIN
		select @DesTexto = isnull(des_texto,'') from notas where cod_nota=@CodNota
		UPDATE @TablaTemporal SET DesTexto = @DesTexto WHERE CodNota = @CodNota
	FETCH	NEXT FROM CURSOR_EDICIONIMPRESA INTO @CodNota
	END
	CLOSE CURSOR_EDICIONIMPRESA 
	DEALLOCATE CURSOR_EDICIONIMPRESA 
end
SELECT	CodNota As CodigoNota,
	CodSeccion AS CodigoSeccion,
	NomSeccion as Seccion,
	DesTituloNota as TituloNota,
	DesCcabecera as Bajada,
	DesVolada as Volada,
	DesAutor as Autor,
	NumPrioridad as Prioridad,
	FecRegistro as FechaNota,
	DesPagina as PDFRelacionado,
	DesTexto as Cuerpo						
FROM @TablaTemporal



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE   procedure sp_IngresaArchivosXAsignar
@sNombreArchivo varchar(100)
AS
Declare
@ID_ArchivoXAsignar int
SET @ID_ArchivoXAsignar=(SELECT MAX(ID_ArchivoXAsignar) FROM ArchivosXAsignar)

if @ID_ArchivoXAsignar is null
set @ID_ArchivoXAsignar=1
else
set @ID_ArchivoXAsignar=@ID_ArchivoXAsignar+1
insert into ArchivosXAsignar
values
(
 	@ID_ArchivoXAsignar,
	@sNombreArchivo,
	1	
)





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE dbo.sp_IngresaCuerpo
@Cod_Cuerpo varchaR(2)
AS
INSERT CUERPO 
(
Cod_Cuerpo
)
VALUES
(
@Cod_Cuerpo
)


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE   PROCEDURE dbo.sp_IngresaCuerpoFolio
@iID_Cuerpo int,
@iID_Folio int,
@iID_Seccion smallint
AS
Declare 
@ID_CuerpoFolio numeric

SET @ID_CuerpoFolio=isnull((SELECT MAX(ID_CuerpoFolio) FROM cuerpofolio),1)
SET @ID_CuerpoFolio = @ID_CuerpoFolio +1
Insert Into cuerpofolio
(
ID_CuerpoFolio,
ID_Cuerpo,
ID_Folio,
ID_Seccion
)
values
(
@ID_CuerpoFolio,
@iID_Cuerpo,
@iID_Folio,
@iID_Seccion
)





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE  PROCEDURE dbo.sp_IngresaFolio
@cod_folio varchar(4),
@nom_folio varchar(20)
As
Insert Into Folios
( cod_folio,
  nom_folio
)
Values
( @cod_folio,
  @nom_folio
)



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





CREATE    PROCEDURE dbo.sp_IngresaPaginasErradas
@sdes_pagina varchar(300),
@Fecha int,
@sSeccionID varchar(50)
AS
Declare
@iIdPagina integer,
@n_fecha_modifica integer,
@n_hora_modifica integer

EXEC sp_fec_formato @n_fecha_modifica OUTPUT 
EXEC sp_hor_formato @n_hora_modifica OUTPUT 

SET @iIdPagina =(select isnull(MAX(id_pagina),0) from PaginasErradas)
SET @iIdPagina = @iIdPagina + 1

Insert into PaginasErradas
(id_pagina,des_pagina,Fecha,SeccionID,FechaRegistro,HoraRegistro)
values
(@iIdPagina,@sdes_pagina,@Fecha,@sSeccionID,@n_fecha_modifica,@n_hora_modifica)





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.sp_IngresaTemporales_Online
AS
SET NOCOUNT ON
BEGIN
Begin TRAN 
DELETE FROM ivmakernew..TempGeneraImpresa_Online 
DELETE FROM Suplemento_Online
--INSERT INTO ivmakernew..TempGeneraImpresa_Online SELECT * FROM ivmakernew..TempGeneraImpresa
INSERT INTO ivmakernew..TempGeneraImpresa_Online SELECT * FROM ivmakernew..TempGeneraEdicionImpresa
INSERT INTO Suplemento_Online SELECT * FROM Suplemento

IF @@ERROR = 0 
COMMIT TRANSACTION 
ELSE
ROLLBACK TRANSACTION 
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sp_ListaArchivosXAsignar
As
SELECT * FROM  ArchivosXAsignar where estado=1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





CREATE    PROCEDURE dbo.sp_ListaCuerpo
@Cod_Estado smallint
AS
if @Cod_Estado='1' or @Cod_Estado='0'
SELECT ID_Cuerpo AS Codigo,Cod_Cuerpo as Cuerpo,Cod_Estado as Estado FROM CUERPO WHERE Cod_Estado=@Cod_Estado
ELSE
SELECT ID_Cuerpo AS Codigo,Cod_Cuerpo as Cuerpo,Cod_Estado as Estado FROM CUERPO 





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE   PROCEDURE dbo.sp_ListaCuerpoFolio
@ID_CuerpoFolio as numeric
AS
SELECT	CF.ID_CuerpoFolio AS 'Codigo',
	CF.ID_Cuerpo AS 'Cod. Cuerpos',
	C.Cod_Cuerpo AS Cuerpo,
	CF.ID_Folio AS 'Cod. Folio',
	F.Cod_Folio as 'Folio',
	F.nom_folio AS 'Nombre Folio',
	CF.ID_Seccion AS 'Cod. Sección',
	S.nom_seccion AS 'Sección'
FROM	CUERPOFOLIO CF,
	CUERPO C,
	FOLIOS F,
	SECCION S	
WHERE	CF.ID_Cuerpo=C.ID_Cuerpo 
	AND CF.ID_Folio = F.ID_Folio
	AND CF.ID_Seccion = S.Cod_Seccion
ORDER BY C.Cod_Cuerpo,F.nom_folio 




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sp_ListaDetalleNota 
@icod_nota as integer
AS
/*SELECT  dbo.Notas.des_tituloNota, 
	dbo.Notas.des_cabecera, 
	dbo.Notas.des_volada, 
	dbo.Notas.des_texto, 
	dbo.Notas.des_autor, 
	dbo.FotoNota.des_sumillafoto, 
             dbo.Foto.des_autor AS fotografo
FROM    dbo.Foto RIGHT OUTER JOIN
        dbo.FotoNota ON dbo.Foto.cod_foto = dbo.FotoNota.cod_nota RIGHT OUTER JOIN
        dbo.Notas ON dbo.FotoNota.cod_nota = dbo.Notas.cod_nota
WHERE	dbo.Notas.cod_nota=@icod_nota*/
SELECT  dbo.Notas.des_tituloNota, 
	dbo.Notas.des_cabecera, 
	dbo.Notas.des_volada, 
	dbo.Notas.des_texto, 
	dbo.Notas.des_autor,
	dbo.FotoNota.des_sumillafoto,
	dbo.Foto.des_autor AS fotografo
FROM    dbo.Notas,dbo.FotoNota,dbo.Foto
WHERE	dbo.Notas.cod_nota=@icod_nota and
	dbo.Notas.cod_nota=dbo.FotoNota.cod_nota and
	dbo.FotoNota.cod_foto=dbo.Foto.cod_foto

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO




CREATE   PROCEDURE dbo.sp_ListaFolio
@codigo int
AS
SELECT	F.ID_Folio AS Codigo,
	F.cod_folio as Folio,
	F.nom_folio as Descripcion
FROM FOLIOS F
ORDER BY 2




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE     PROCEDURE dbo.sp_ListaNotasXPaginaySeccion
@sDesPagina varchar(30)
AS
declare
@iCodSeccion integer,
@sFechaRegistro varchar(10)
--set @iCodSeccion=430
--set @sDesPagina='ECMU200607b12'
--set @sFechaRegistro='2007/06/20'

SET Language Spanish

--set @iCodSeccion=isnull((select distinct top 1  Cod_Seccion from notas where des_pagina=@sDesPagina and cod_publicacion=59 and est_activo='1'),0)
set @iCodSeccion=isnull((select distinct top 1  Cod_Seccion from notas where des_pagina=@sDesPagina and cod_publicacion=59 and est_activo='1' and cod_seccion<>540),0)
set @sFechaRegistro=(select distinct TOP 1 convert(char(10),fec_registro,111)  from notas where des_pagina=@sDesPagina and cod_publicacion=59 and cod_seccion<>540 and est_activo='1' ORDER BY 1 desc)


if @iCodSeccion=0
begin
--set @iCodSeccion =(select distinct top 1  Cod_Seccion from notas where substring(ltrim(des_pagina),11,1)=substring(ltrim(@sDesPagina),11,1) and cod_publicacion=59 and est_activo='1')	
set @iCodSeccion =(select distinct top 1  Cod_Seccion from notas where substring(ltrim(des_pagina),11,1)=substring(ltrim(@sDesPagina),11,1) and cod_publicacion=59 and est_activo='1' and cod_seccion<>540 AND
 CONVERT(CHAR(10),FEC_REGISTRO,111)=CONVERT(CHAR(10),GETDATE(),111) ORDER BY Cod_Seccion desc)
--set @sFechaRegistro=(select distinct top 1 convert(char(10),fec_registro,111)  from notas where substring(ltrim(des_pagina),11,1)=substring(ltrim(@sDesPagina),11,1) and cod_publicacion=59 and est_activo='1' order by 1 desc)
set @sFechaRegistro=(select distinct top 1 convert(char(10),fec_registro,111)  from notas where substring(ltrim(des_pagina),11,1)=substring(ltrim(@sDesPagina),11,1) and cod_publicacion=59 and est_activo='1'
 and cod_seccion<>540 AND CONVERT(CHAR(10),FEC_REGISTRO,111)=CONVERT(CHAR(10),GETDATE(),111) order by 1 desc)
end


SELECT  n.des_pagina,n.des_titulonota, n.cod_nota, n.cod_seccion,n.fec_registro,
	n.num_prioridad, case when @sDesPagina=rtrim(n.des_pagina) then   '*' else '' end as NotaPagina,convert(char(5),n.fec_registro,108) as Hora,
	--ltrim(rtrim(s.nom_seccion))as seccion,n.des_nombrepagina, 
	replace(ltrim(rtrim(s.nom_seccion)),'DiaUno','Día 1')as seccion,n.des_nombrepagina,
	n.DES_VOLADA,
	DATENAME(WEEKDAY, n.fec_registro) AS DIA_SEMANA
FROM    Notas n,Seccion s
WHERE   (CONVERT(char(10), n.fec_registro, 111) =@sFechaRegistro ) AND 
	--(n.des_pagina=@sDesPagina) AND
	(n.cod_seccion = @iCodSeccion) AND 
	(n.des_pagina <> '') AND 
	(n.est_activo = '1') AND
	(n.cod_publicacion = 59) 	and
	n.cod_seccion=s.cod_seccion AND
	n.cod_seccion<>540     
GROUP BY n.des_pagina,n.des_titulonota, n.cod_nota, n.cod_seccion, n.fec_registro,n.num_prioridad,s.nom_seccion,n.des_nombrepagina, n.DES_VOLADA
ORDER BY n.num_prioridad ASC
/*UNION
SELECT  n.des_pagina, n.des_titulonota,n.cod_nota, n.cod_seccion,n.fec_registro,n.num_prioridad,'' as NotaPagina,
	--convert(char(5),n.fec_registro,108) as Hora,ltrim(rtrim(s.nom_seccion))as seccion,n.des_nombrepagina,
	convert(char(5),n.fec_registro,108) as Hora,replace(ltrim(rtrim(s.nom_seccion)),'DiaUno','Día 1')as seccion,n.des_nombrepagina,
	n.DES_VOLADA,
	DATENAME(WEEKDAY, n.fec_registro) AS DIA_SEMANA
FROM    Notas n,Seccion s
WHERE   (CONVERT(char(10), n.fec_registro, 111) = @sFechaRegistro) AND 
	(n.des_pagina<>@sDesPagina)AND
	(n.cod_seccion = @iCodSeccion) AND 
	(n.des_pagina <> '') AND 
	(n.est_activo = '1') AND
	(n.cod_publicacion = 59) AND
	n.cod_seccion=s.cod_seccion AND
	n.cod_seccion<>540
GROUP BY n.des_pagina,n.des_titulonota, n.cod_nota, n.cod_seccion, n.fec_registro,n.num_prioridad,s.nom_seccion,n.des_nombrepagina, n.DES_VOLADA
ORDER BY n.num_prioridad ASC */














GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE     PROCEDURE dbo.sp_ListaNotasXPaginaySeccion_movil      
@sDesPagina varchar(30)      
AS      
declare      
@iCodSeccion integer,      
@sFechaRegistro varchar(10)      
--@sDesPagina varchar(30)      
--set @iCodSeccion=430      
--set @sDesPagina='ecpr080908d1'      
--set @sFechaRegistro='2007/06/20'      
      
SET Language Spanish      
      
set @iCodSeccion=isnull((select distinct top 1  Cod_Seccion from notas where des_pagina=@sDesPagina and cod_publicacion=59 and est_activo='1' and cod_seccion<>540),0)      
set @sFechaRegistro=(select distinct TOP 1 convert(char(10),fec_registro,111)  from notas where des_pagina=@sDesPagina and cod_publicacion=59 and cod_seccion<>540 and est_activo='1' ORDER BY 1 desc)      
      
      
if @iCodSeccion=0      
begin      
set @iCodSeccion =(select distinct top 1  Cod_Seccion       
from notas where substring(ltrim(des_pagina),11,1)=substring(ltrim(@sDesPagina),11,1) and cod_publicacion=59  and cod_seccion<>540 and       
  CONVERT(CHAR(10),FEC_REGISTRO,111)='20'+ substring(ltrim(des_pagina),9,2)+ '/'+ substring(ltrim(des_pagina),7,2)+'/'+ substring(ltrim(des_pagina),5,2)      
 ORDER BY Cod_Seccion desc)      
set @sFechaRegistro=(select distinct top 1 convert(char(10),fec_registro,111)  from notas where substring(ltrim(des_pagina),11,1)=substring(ltrim(@sDesPagina),11,1) and cod_publicacion=59       
 and cod_seccion<>540 AND CONVERT(CHAR(10),FEC_REGISTRO,111)='20'+ substring(ltrim(des_pagina),9,2)+ '/'+ substring(ltrim(des_pagina),7,2)+'/'+substring(ltrim(des_pagina),5,2) order by 1 desc)      
end      
      
       
SELECT  n.des_pagina,n.des_titulonota, n.cod_nota, n.cod_seccion,n.fec_registro,      
 n.num_prioridad, case when @sDesPagina=rtrim(n.des_pagina) then   '*' else '' end as NotaPagina,convert(char(5),n.fec_registro,108) as Hora,      
 replace(ltrim(rtrim(s.nom_seccion)),'DiaUno','Día 1')as seccion,n.des_nombrepagina,      
 n.DES_VOLADA,      
 DATENAME(WEEKDAY, n.fec_registro) AS DIA_SEMANA      
FROM    Notas n,Seccion s      
WHERE   (CONVERT(char(10), n.fec_registro, 111) =@sFechaRegistro ) AND       
 (n.cod_seccion = @iCodSeccion) AND       
 (n.des_pagina <> '') AND       
 (n.cod_publicacion = 59)  and      
 n.cod_seccion=s.cod_seccion AND      
 n.cod_seccion<>540           
GROUP BY n.des_pagina,n.des_titulonota, n.cod_nota, n.cod_seccion, n.fec_registro,n.num_prioridad,s.nom_seccion,n.des_nombrepagina, n.DES_VOLADA      
ORDER BY n.num_prioridad ASC      
  


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE 	PROCEDURE dbo.sp_ListaNotasXPaginaySeccion_rtc
@sDesPagina varchar(30)
AS
declare
@iCodSeccion integer,
@sFechaRegistro varchar(10)

SET Language Spanish

set @iCodSeccion = isnull((select distinct top 1  Cod_Seccion 
			from 	IVMAKER..notas 
			where 	des_pagina = @sDesPagina and cod_publicacion = 59 ),0)
set @sFechaRegistro = (select 	distinct TOP 1 convert(char(10),fec_registro,111) 
			from 	IVMAKER..notas 
			where 	des_pagina = @sDesPagina and cod_publicacion = 59 
			ORDER 	BY 1 desc)

if @iCodSeccion = 0
begin
 set @iCodSeccion =	(select distinct top 1  Cod_Seccion 
			from 	IVMAKER..notas 
			where 	substring(ltrim(des_pagina),11,1) = substring(ltrim(@sDesPagina),11,1) and cod_publicacion=59 )
 set @sFechaRegistro = 	(select distinct top 1 convert(char(10),fec_registro,111) 
			from 	IVMAKER..notas 
			where 	substring(ltrim(des_pagina),11,1) = substring(ltrim(@sDesPagina),11,1) and cod_publicacion = 59 
			order 	by 1 desc)
end


SELECT  n.des_pagina, n.des_titulonota, n.cod_nota, n.cod_seccion, n.fec_registro,
	n.num_prioridad,'*' as NotaPagina, convert(char(5),n.fec_registro,108) as Hora,
	ltrim(rtrim(s.nom_seccion))as seccion, n.des_nombrepagina, 
	n.DES_VOLADA,
	DATENAME(WEEKDAY, n.fec_registro) AS DIA_SEMANA
FROM    IVMAKER..Notas n,Seccion s
WHERE   (CONVERT(char(10), n.fec_registro, 111) = @sFechaRegistro ) 
	AND (n.des_pagina = @sDesPagina) 
	AND(n.cod_seccion = @iCodSeccion) 
	AND (n.des_pagina <> '') 
--	AND (n.est_activo = '1') 
	AND (n.cod_publicacion = 59) 
	and n.cod_seccion = s.cod_seccion
GROUP 	BY n.des_pagina,n.des_titulonota, n.cod_nota, n.cod_seccion, n.fec_registro,n.num_prioridad,s.nom_seccion,n.des_nombrepagina, n.DES_VOLADA

UNION
SELECT  n.des_pagina, n.des_titulonota,n.cod_nota, n.cod_seccion,n.fec_registro,n.num_prioridad,'' as NotaPagina,
	convert(char(5),n.fec_registro,108) as Hora,ltrim(rtrim(s.nom_seccion))as seccion,n.des_nombrepagina,
	n.DES_VOLADA,
	DATENAME(WEEKDAY, n.fec_registro) AS DIA_SEMANA
FROM    IVMAKER..Notas n, IVMAKER..Seccion s
WHERE   (CONVERT(char(10), n.fec_registro, 111) = @sFechaRegistro) 
	AND (n.des_pagina <> @sDesPagina) 
	AND (n.cod_seccion = @iCodSeccion) 
	AND (n.des_pagina <> '') 
--	AND (n.est_activo = '1') 
	AND (n.cod_publicacion = 59) 
	AND n.cod_seccion = s.cod_seccion 
GROUP 	BY n.des_pagina,n.des_titulonota, n.cod_nota, n.cod_seccion, n.fec_registro,n.num_prioridad,s.nom_seccion,n.des_nombrepagina, n.DES_VOLADA
ORDER 	BY n.num_prioridad ASC


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.sp_ListaNotasXSeccion
@iCodNota integer
AS
declare
@iCodSeccion smallint,
@sFecRegistro varchar(10)

SELECT @iCodSeccion=Cod_Seccion,@sFecRegistro=convert(char(10),fec_registro,111) From notas Where cod_nota=@iCodNota
select	cod_nota,des_tituloNota,convert(char(5),fec_registro,108) as Hora,
	convert(char(10),fec_registro,111) as Fecha
from	notas 
where	convert(char(10),fec_registro,111)=@sFecRegistro and 
	cod_seccion=@iCodSeccion and
	cod_nota<>@iCodNota 
order by num_prioridad

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO





CREATE    procedure dbo.sp_ListaPaginasErradas
@Codigo integer
--@Fecha int
As
--select ID_Pagina,Des_pagina from PaginasErradas
select * from PaginasErradas 



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.sp_ListaPaginasPublicacion
--@sFechaRegistro varchar(10)
AS
/*select	des_pagina
from	notas 
where	convert(char(10),fec_registro,111)=@sFechaRegistro  and 
	est_activo=1 and est_archivo=1 and cod_publicacion=59 and
	des_pagina <>''
group by des_pagina
order by substring(ltrim(rtrim(des_pagina)),11,1),CONVERT(SMALLINT,LTRIM(RTRIM(substring(ltrim(rtrim(des_pagina)),12,2))))ASC*/
--select NombreArchivo as des_pagina from  ivmakernew..tempgeneraimpresa order by codigo
select NombreArchivo as des_pagina,
	case substring(ltrim(NombreArchivo),11,1) 
	  when 'A' THEN 'Cuerpo A'
	  when 'B' THEN 'Cuerpo B'
	  when 'C' THEN 'Cuerpo C'
	  else ''
	end As Cuerpo	
--from  ivmakernew..tempgeneraimpresa 
from	ivmakernew..TempGeneraEdicionImpresa
Where len(ltrim(rtrim(NombreArchivo)))>5
order by codigo

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.sp_ListaPaginasSeccionSuplemento
AS
SET NOCOUNT ON
DECLARE
@TablaTemporal
TABLE 
(
	codigo INT,
	des_pagina varchar(50),
	Secciones varchar(50),
	est_seccion CHAR(1),
	est_suplemento CHAR(1)
)
INSERT INTO @TablaTemporal 
SELECT	codigo,NombreArchivo,Secciones,est_seccion,est_suplemento  
--from	ivmakernew..tempGeneraImpresa 
from	ivmakernew..TempGeneraEdicionImpresa
WHERE	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),11,1))<>' '	 AND
	flagPDF='1'
ORDER BY 1
/*INSERT INTO @TablaTemporal 

SELECT	codigo,NombreArchivo,Secciones,est_seccion,est_suplemento 
--from	ivmakernew..tempGeneraImpresa 
from	ivmakernew..TempGeneraEdicionImpresa
WHERE	(UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),11,1))='G' AND 
	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),3,2))='DT') or
	(UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),11,1))='G' AND 
	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),3,2))='PR') and
	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),11,1))<>' '	 
	and flagPDF='1'
GROUP BY codigo,NombreArchivo,Secciones,est_seccion,est_suplemento 
ORDER BY 1
INSERT INTO @TablaTemporal 
SELECT	codigo,NombreArchivo,Secciones,est_seccion,est_suplemento  
--from	ivmakernew..tempGeneraImpresa 
from	ivmakernew..TempGeneraEdicionImpresa
WHERE	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),11,1))='G' AND
	UPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),3,2))<>'DT'AND
	UPPER(SUUPPER(SUBSTRING(LTRIM(NOMBREARCHIVO),11,1))<>' '  AND
	flagPDF='1'  
GROUP BY SUBSTRING(LTRIM(NOMBREARCHIVO),3,2) ,codigo,NombreArchivo,Secciones,est_seccion,est_suplemento 
ORDER BY codigo */
SELECT * FROM @TablaTemporal










GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE procedure dbo.sp_ListaPaginasSuplemento
AS
SELECT seccion as Secciones ,ruta_pagina FROM Suplemento where est_registro='1' order by prioridad


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE 	procedure sp_ListaPaginasSuplemento_OnLine
AS
SELECT seccion as Secciones ,ruta_pagina FROM IVMAKER..Suplemento_OnLine where est_registro='1' order by prioridad






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE  PROCEDURE dbo.sp_ListaSecciones
@Estado char(1)
AS
SELECT cod_seccion AS Codigo,nom_seccion  as Seccion
FROM Seccion 
WHERE est_activo=@Estado and cod_publicacion=59 
order by nom_seccion



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.sp_ListaUsuarioTemperatura
AS
Declare
@sUsuario varchar(20),
@sTemperatura varchar(5)
set @sUsuario =isnull((select des_cabecera from ivmakernew..notas where cod_seccion=764 and num_prioridad<>'' and num_prioridad =4 ),'0')
set @sTemperatura=isnull((select top 1 des_cabecera from ivmakernew..notas where cod_seccion=764 and num_prioridad<>'' and num_prioridad =1 ),'0')
select @sUsuario as Usuario,@sTemperatura as Temperatura

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create PROCEDURE sp_SacaUltimoContracorriente
--Este sp da la ruta del ultimo contracorriente
as 
select '/edicionimpresa/html/20'+substring(des_pagina,9,2)+'-'+substring(des_pagina,7,2)+'-'+substring(des_pagina,5,2)+'/'+ rtrim(des_pagina)+ '.html' as ContraCorriente
 from notas_pdf 
where des_pagina like 'eccc%' 
and fec_registro >=getdate()-7
order by fec_registro desc

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE dbo.sp_SeguimientoEdicionImpresa
@sFecha as varchar(10)
AS
SET NOCOUNT ON
DECLARE
@TablaTemporal
TABLE 
(
	Cod_Seccion INT,
	Nom_Seccion VARCHAR(200),
	NroNotas INT
)
DECLARE
@iCod_Seccion INTEGER,
@sNom_Seccion VARCHAR(200),
@iNroNotas INTEGER
DECLARE	CURSOR_SECCION_NOTAS CURSOR FOR
select cod_seccion,nom_seccion from seccion where cod_publicacion=59 and est_activo=1 order by 2
OPEN	CURSOR_SECCION_NOTAS 
FETCH	NEXT FROM CURSOR_SECCION_NOTAS INTO @iCod_Seccion, @sNom_Seccion
WHILE 	@@FETCH_STATUS = 0
BEGIN
	--SET @iNroNotas=(select COUNT(*) from notas where convert(char(10),fec_registro,103)='25/07/2007' and cod_seccion=@iCod_Seccion)
	SET @iNroNotas=(select COUNT(*) from notas where convert(char(10),fec_registro,103)=@sFecha and cod_seccion=@iCod_Seccion)
	/**********INSERTANDO LOS DATOS EN LA TABLA TEMPORAL**********/
	INSERT INTO @TablaTemporal VALUES(@iCod_Seccion,@sNom_Seccion,@iNroNotas)
	/**************************************************************/
FETCH	NEXT FROM CURSOR_SECCION_NOTAS INTO @iCod_Seccion, @sNom_Seccion
END
CLOSE CURSOR_SECCION_NOTAS
DEALLOCATE CURSOR_SECCION_NOTAS 
SELECT * FROM @TablaTemporal



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE  PROCEDURE dbo.sp_SelccionaNombreSeccion
@cod_seccion integer
AS
select ltrim(rtrim(nom_seccion)) from seccion where cod_seccion=@cod_seccion

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.sp_SeleccionaEditor
@sFecha char(10)
AS
select	cod_nota,
	des_titulonota 
from	notas 
where	convert(char(10),fec_registro,111)=@sFecha and 
	cod_publicacion=59 and 
	cod_seccion=431 and 
	num_prioridad=3

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE      PROCEDURE dbo.sp_SeleccionaSeccion
@sCod_Cuerpo char(1),
@scod_folio varchar(4)
AS
declare
@iID_Cuerpo numeric,
@iID_Folio numeric,
@ID_Seccion numeric

--set @sCod_Cuerpo='A'
--SET @scod_folio='AC'

set @iID_Cuerpo=isnull((select ID_Cuerpo from cuerpo where Cod_Cuerpo=@sCod_Cuerpo),0)
set @iID_Folio=isnull((Select ID_Folio From folios where cod_folio=@scod_folio),0)
--SELECT @iID_Cuerpo,@iID_Folio
set @ID_Seccion=(select top 1 ID_Seccion from cuerpofolio where ID_Cuerpo=@iID_Cuerpo and ID_Folio=@iID_Folio)
if @ID_Seccion is null
   set @ID_Seccion=0
select @ID_Seccion as Seccion,@iID_Cuerpo as Cuerpo,@iID_Folio as Folio

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.sp_TraeNombrePagina  
@iCodigoNota integer  
AS  
declare
@sCodPublicacion smallint
set @sCodPublicacion=0
set @sCodPublicacion=(Select cod_publicacion From Notas where cod_nota=@iCodigoNota)
if @sCodPublicacion<>59
begin
	select des_nombrepagina,cod_publicacion,dbo.LimpiaTituloHTML(lower(des_tituloNota))as Titulo   
	from notas   
	where   cod_nota=@iCodigoNota   
	 	AND des_nombrepagina is not null  
		AND LTRIM(RTRIM(des_nombrepagina))<>''  
end
else
begin
	select des_nombrepagina,cod_publicacion,dbo.LimpiaTituloHTML(lower(des_tituloNota))as Titulo   
	from notas   
	where   cod_nota=@iCodigoNota   

end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE  PROCEDURE sp_fec_formato
(@n_fecha NUMERIC(8) OUTPUT)
AS
BEGIN
/*--------------------------------------*/
/* CAPTURA LA FECHA DEL SERVIDOR CON EL FORMATO PARA GRABARLA EN LAS TABLAS	*/
/*--------------------------------------*/
/* Creador: Alfredo Acevedo */
/* Funcion: Accesar a este SP directamente de los SP's que graban campos de Auditoria */
/*--------------------------------------*/

DECLARE @c_relleno CHAR(1)
SELECT @c_relleno = '0'

SELECT	@n_fecha = CAST(
 	CASE WHEN LEN(CAST(DATEPART(YY,GETDATE()) AS VARCHAR(4)))=1 THEN @c_relleno + CAST(DATEPART(YY,GETDATE()) AS VARCHAR(4)) ELSE CAST(DATEPART(YY,GETDATE()) AS VARCHAR(4)) END +
	CASE WHEN LEN(CAST(DATEPART(MM,GETDATE()) AS VARCHAR(2)))=1 THEN @c_relleno + CAST(DATEPART(MM,GETDATE()) AS VARCHAR(2)) ELSE CAST(DATEPART(MM,GETDATE()) AS VARCHAR(2)) END +
	CASE WHEN LEN(CAST(DATEPART(DD,GETDATE()) AS VARCHAR(2)))=1 THEN @c_relleno + CAST(DATEPART(DD,GETDATE()) AS VARCHAR(2)) ELSE CAST(DATEPART(DD,GETDATE()) AS VARCHAR(2)) END
	AS NUMERIC)

END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE  PROCEDURE sp_hor_formato
(@n_hora NUMERIC(8) OUTPUT)
AS
BEGIN
/*--------------------------------------*/
/* CAPTURA LA HORA DEL SERVIDOR CON EL FORMATO PARA GRABARLA EN LAS TABLAS	*/
/*--------------------------------------*/
/* Creador: Alfredo Acevedo */
/* Funcion: Accesar a este SP directamente de los SP's que graban campos de Auditoria */
/*--------------------------------------*/
DECLARE @c_relleno CHAR(1)
SELECT @c_relleno = '0'

SELECT 	@n_hora = CAST(
	CASE WHEN LEN(CAST(DATEPART(HH,GETDATE()) AS VARCHAR(2)))=1 THEN @c_relleno + CAST(DATEPART(HH,GETDATE()) AS VARCHAR(2)) ELSE CAST(DATEPART(HH,GETDATE()) AS VARCHAR(2)) END +
	CASE WHEN LEN(CAST(DATEPART(MI,GETDATE()) AS VARCHAR(2)))=1 THEN @c_relleno + CAST(DATEPART(MI,GETDATE()) AS VARCHAR(2)) ELSE CAST(DATEPART(MI,GETDATE()) AS VARCHAR(2)) END +
	CASE WHEN LEN(CAST(DATEPART(SS,GETDATE()) AS VARCHAR(2)))=1 THEN @c_relleno + CAST(DATEPART(SS,GETDATE()) AS VARCHAR(2)) ELSE CAST(DATEPART(SS,GETDATE()) AS VARCHAR(2)) END
	AS NUMERIC)

END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE	FUNCTION LimpiaHTML(@pagina as varchar(30))
RETURNS varchar(500)
AS
BEGIN

	set  @pagina=(RTrim(LTrim(@pagina)))
	set  @pagina=Replace(Replace(Replace(Replace(Replace(Replace(@pagina,' a ',' '),' e ',' '),' i ',' '),' o ',' '),' u ',' '),' el ',' ')
	set  @pagina=Replace(Replace(Replace(Replace(Replace(Replace(@pagina,' en ',' '),' la ',' '),' las ',' '),' es ',' '),' tras ',' '),' del ',' ')
	set  @pagina=Replace(Replace(Replace(Replace(Replace(Replace(@pagina,' pero ',' '),' para ',' '),' por ',' '),' de ',' '),' con ',' '),' se ',' ')
	set  @pagina=Replace(Replace(Replace(Replace(Replace(Replace(@pagina,' sera ',' '),' haber ',' '),' una ',' '),' un ',' '),' unos ',' '),' los ',' ')
	set  @pagina=Replace(Replace(@pagina,' debe ' ,' '),' ser ',' ')
	set  @pagina=Replace(@pagina,' ' ,'-')
	set  @pagina=Replace(Replace(Replace(Replace(Replace(@pagina,'á','a'),'é','e'),'í','i'),'ó','o'),'ú','u')
	set  @pagina=Replace(Replace(Replace(Replace(Replace(Replace(@pagina,'ñ','n'),'¿',''),'?',''),'¡',''),'!',''),'','')
	set  @pagina=Replace(Replace(Replace(Replace(Replace(Replace(@pagina,'&',''),'$',''),'#',''),'@',''),'/',''),'\','')
	set  @pagina=replace(Replace(Replace(Replace(Replace(Replace(@pagina,'.',''),',',''),'''',''),':',''),';',''),',','')
	set @pagina=replace(replace(replace(replace(replace(@pagina,'%',''),'ï','i'),')',''),'(',''),'*','')
	set  @pagina=replace(replace(replace(replace(replace(@pagina,'<',''),'>',''),'=',''),'[',''),']','')
	set @pagina=replace(replace(replace(replace(replace(replace(@pagina,'^',''),'{',''),'}',''),'~',''),'Á','A'),'É','E')
	set @pagina=replace(replace(replace(replace(replace(replace(@pagina,'Í','i'),'Ó','o'),'Ú','u'),'Ä','a'),'Ë','e'),'Ï','i')
	set @pagina=replace(replace(replace(replace(replace(replace(@pagina,'Ö','o'),'Ü','u'),'ä','a'),'ë','e'),'ö','o'),'ü','u')
	set @pagina=replace(replace(replace(@pagina,'ÿ','y'),'Ñ','n'),'"','')
   RETURN ( @pagina )
END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE	FUNCTION LimpiaTituloHTML(@pagina as varchar(500))
RETURNS varchar(500)
AS
BEGIN

	set  @pagina=(RTrim(LTrim(@pagina)))
	set  @pagina=Replace(Replace(Replace(Replace(Replace(Replace(@pagina,' a ',' '),' e ',' '),' i ',' '),' o ',' '),' u ',' '),' el ',' ')
	set  @pagina=Replace(Replace(Replace(Replace(Replace(Replace(@pagina,' en ',' '),' la ',' '),' las ',' '),' es ',' '),' tras ',' '),' del ',' ')
	set  @pagina=Replace(Replace(Replace(Replace(Replace(Replace(@pagina,' pero ',' '),' para ',' '),' por ',' '),' de ',' '),' con ',' '),' se ',' ')
	set  @pagina=Replace(Replace(Replace(Replace(Replace(Replace(@pagina,' sera ',' '),' haber ',' '),' una ',' '),' un ',' '),' unos ',' '),' los ',' ')
	set  @pagina=Replace(Replace(@pagina,' debe ' ,' '),' ser ',' ')
	set  @pagina=Replace(@pagina,' ' ,'-')
	set  @pagina=Replace(Replace(Replace(Replace(Replace(@pagina,'á','a'),'é','e'),'í','i'),'ó','o'),'ú','u')
	set  @pagina=Replace(Replace(Replace(Replace(Replace(Replace(@pagina,'ñ','n'),'¿',''),'?',''),'¡',''),'!',''),'','')
	set  @pagina=Replace(Replace(Replace(Replace(Replace(Replace(@pagina,'&',''),'$',''),'#',''),'@',''),'/',''),'\','')
	set  @pagina=replace(Replace(Replace(Replace(Replace(Replace(@pagina,'.',''),',',''),'''',''),':',''),';',''),',','')
	set @pagina=replace(replace(replace(replace(replace(@pagina,'%',''),'ï','i'),')',''),'(',''),'*','')
	set  @pagina=replace(replace(replace(replace(replace(@pagina,'<',''),'>',''),'=',''),'[',''),']','')
	set @pagina=replace(replace(replace(replace(replace(replace(@pagina,'^',''),'{',''),'}',''),'~',''),'Á','A'),'É','E')
	set @pagina=replace(replace(replace(replace(replace(replace(@pagina,'Í','i'),'Ó','o'),'Ú','u'),'Ä','a'),'Ë','e'),'Ï','i')
	set @pagina=replace(replace(replace(replace(replace(replace(@pagina,'Ö','o'),'Ü','u'),'ä','a'),'ë','e'),'ö','o'),'ü','u')
	set @pagina=replace(replace(replace(@pagina,'ÿ','y'),'Ñ','n'),'"','')
   RETURN ( @pagina )
END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER  trgAdicionaNota ON dbo.Notas 
FOR INSERT
AS
	UPDATE seccion
	SET est_generadoindice = '0'
	FROM seccion, inserted	
	WHERE seccion.cod_seccion=inserted.cod_seccion

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER trgEliminaNota ON dbo.Notas 
FOR DELETE
AS
	DELETE fotonota FROM fotonota, deleted
	WHERE fotonota.cod_nota=deleted.cod_nota

	DELETE notasrelacionadas FROM notasrelacionadas, deleted
	WHERE notasrelacionadas.cod_nota=deleted.cod_nota

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER trg_Archiva ON dbo.Notas 
FOR  UPDATE, insert

AS
declare @archivo char(1),
	@activo char(1),
	@codigo int
begin 
	select @archivo=inserted.est_archivo from inserted
	select @activo =inserted.est_Activo from inserted
	select @codigo =inserted.cod_nota from inserted
if (@archivo='0' and @activo='1' )
update notas set est_activo='0' where cod_nota =@codigo

end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER LimpiaDesPagina_pdf
ON notas
FOR Insert
AS 
BEGIN
declare @des_pagina char(30),
        @cod_nota int
	select @des_pagina=replace(upper(des_pagina),'.PDF',''), @cod_nota=cod_nota  from inserted where cod_publicacion=59 and  des_pagina is not null
	update notas set des_pagina=@des_pagina where cod_nota=@cod_nota		

END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER trgEliminaPublicacion ON dbo.Publicacion 
FOR DELETE 
AS
	DELETE seccion FROM seccion, deleted
	WHERE seccion.cod_publicacion=deleted.cod_publicacion
	DELETE usuarioperfil FROM usuarioperfil, deleted
	WHERE usuarioperfil.cod_publicacion=deleted.cod_publicacion
	DELETE publicacionmodulo FROM publicacionmodulo, deleted
	WHERE publicacionmodulo.cod_publicacion=deleted.cod_publicacion
	DELETE plantillas FROM plantillas, deleted
	WHERE plantillas.cod_publicacion=deleted.cod_publicacion

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE TRIGGER trgEliminaSeccion ON dbo.Seccion 
FOR DELETE
AS
	DELETE notas FROM notas, deleted
	WHERE notas.cod_seccion=deleted.cod_seccion

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE  TRIGGER TR_ACTUALIZA_TEXTO
ON NOTASGDA
FOR INSERT
AS
UPDATE	NOTASGDA
SET 	NOTASGDA.DES_TEXTO = replace(convert(varchar(8000), n.des_texto), '<P align=justify>', '<p>')
FROM 	NOTASGDA n, INSERTED i
WHERE	i.COD_NOTA = n.COD_NOTA



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

