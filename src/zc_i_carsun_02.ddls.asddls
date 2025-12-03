@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Carga para bloqueo SUNAT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_I_CARSUN_02 
with parameters 
    P_TAXNU: stcd1

as select from ZC_I_CARSUN_01
inner join I_Supplier
    on ZC_I_CARSUN_01.Supplier = I_Supplier.Supplier
{
    key I_Supplier.TaxNumber1  as NIF,                 // NIF del acreedor
    key ZC_I_CARSUN_01.Supplier
}
where 
    I_Supplier.TaxNumber1  = $parameters.P_TAXNU
group by
    I_Supplier.TaxNumber1,
    ZC_I_CARSUN_01.Supplier
;
