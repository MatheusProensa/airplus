package com.sulake.habbo.catalog
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.catalog.navigation.ICatalogNavigator;
   import com.sulake.habbo.catalog.navigation.RequestedPage;
   import com.sulake.habbo.catalog.viewer.CatalogViewer;
   
   public class CatalogWindowState
   {
      public var catalogType:String;
      
      public var mainContainer:IWindowController_1;
      
      public var catalogViewer:CatalogViewer;
      
      public var catalogNavigator:ICatalogNavigator;
      
      public var UnknownVarFromCatalogWindowState_RequestedPage_1:RequestedPage;
      
      public var lastPageRequestId:int = -1;
      
      public function CatalogWindowState(param1:String)
      {
         super();
         this.catalogType = param1;
         UnknownVarFromCatalogWindowState_RequestedPage_1 = new RequestedPage();
      }
      
      public function dispose() : void
      {
         if(catalogViewer != null)
         {
            catalogViewer.dispose();
            catalogViewer = null;
         }
         if(catalogNavigator != null)
         {
            catalogNavigator.dispose();
            catalogNavigator = null;
         }
         if(mainContainer != null)
         {
            mainContainer.dispose();
            mainContainer = null;
         }
         UnknownVarFromCatalogWindowState_RequestedPage_1 = null;
         catalogType = null;
         lastPageRequestId = -1;
      }
   }
}

