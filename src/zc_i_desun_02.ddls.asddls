@AbapCatalog.sqlViewName: 'ZC_I_DESUN_02_RT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Descarga Sunat txt'
@Metadata.ignorePropagatedAnnotations: true
define view ZC_I_DESUN_02
with parameters 
    P_BUKRS : bukrs,
    P_LAUFI : laufi,
    P_LAUFD : laufd,
    P_BLART : blart
    //P_MINIMO : dmbtr

as select from ZC_I_DESUN_01
inner join I_Supplier
    on ZC_I_DESUN_01.Supplier = I_Supplier.Supplier
{
    key I_Supplier.TaxNumber1  as NIF,                 // NIF del acreedor
    //sum( ZC_I_DESUN_01.NetAmountInTransacCurrency )*(-1) as Total  // Total de la suma por Acreedor
    sum( ZC_I_DESUN_01.NetAmountInCoCodeCurrency  )*(-1) as Total  // Total de la suma por Acreedor
    
}
where 
    ZC_I_DESUN_01.CompanyCode  = $parameters.P_BUKRS and
    ZC_I_DESUN_01.PaymentRunID  = $parameters.P_LAUFI and
    ZC_I_DESUN_01.PaymentRunDate  = $parameters.P_LAUFD and
    ZC_I_DESUN_01.ParameterID  = $parameters.P_BLART
    //ZC_I_DESUN_01.PaymentDocument is not null
    //ZC_I_DESUN_01.AmountInFunctionalCurrency >= $parameters.P_MINIMO
group by
    I_Supplier.TaxNumber1
;
