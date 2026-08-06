package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   
   public class FurnitureOffer implements UnknownIHabboCatalog1
   {
      private var UnknownVarFromFurnitureOffer_IFurnitureData_1:IFurnitureData;
      
      private var _previewCallbackId:int;
      
      private var _page:ICatalogPage;
      
      private var _productContainer:FurniProductContainer;
      
      private var _product:Product;
      
      private var UnknownVarFromFurnitureOffer_Int_1:int;
      
      private var UnknownVarFromFurnitureOffer_Boolean_1:Boolean;
      
      public function FurnitureOffer(param1:IFurnitureData, param2:HabboCatalog, param3:int = -1, param4:Boolean = false, param5:String = null)
      {
         super();
         UnknownVarFromFurnitureOffer_IFurnitureData_1 = param1;
         UnknownVarFromFurnitureOffer_Int_1 = param3;
         UnknownVarFromFurnitureOffer_Boolean_1 = param4;
         if(param5 == null || param5.length == 0)
         {
            param5 = UnknownVarFromFurnitureOffer_IFurnitureData_1.className;
         }
         _productContainer = new FurniProductContainer(this,new Vector.<IProduct>(0),param2,UnknownVarFromFurnitureOffer_IFurnitureData_1);
         _product = new Product(UnknownVarFromFurnitureOffer_IFurnitureData_1.type,UnknownVarFromFurnitureOffer_IFurnitureData_1.id,UnknownVarFromFurnitureOffer_IFurnitureData_1.customParams,1,param2.getProductData(param5),UnknownVarFromFurnitureOffer_IFurnitureData_1,param2);
      }
      
      public function dispose() : void
      {
         UnknownVarFromFurnitureOffer_IFurnitureData_1 = null;
         _page = null;
         _previewCallbackId = -1;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromFurnitureOffer_IFurnitureData_1 == null;
      }
      
      public function get offerId() : int
      {
         if(UnknownVarFromFurnitureOffer_Int_1 > -1)
         {
            return UnknownVarFromFurnitureOffer_Int_1;
         }
         return isRentOffer ? UnknownVarFromFurnitureOffer_IFurnitureData_1.rentOfferId : UnknownVarFromFurnitureOffer_IFurnitureData_1.purchaseOfferId;
      }
      
      public function get priceInActivityPoints() : int
      {
         return 0;
      }
      
      public function get activityPointType() : int
      {
         return 0;
      }
      
      public function get priceInCredits() : int
      {
         return 0;
      }
      
      public function get page() : ICatalogPage
      {
         return _page;
      }
      
      public function get priceType() : String
      {
         return "";
      }
      
      public function get productContainer() : IProductContainer
      {
         return _productContainer;
      }
      
      public function get product() : IProduct
      {
         return _product;
      }
      
      public function get gridItem() : IProductGridItem
      {
         return _productContainer as IProductGridItem;
      }
      
      public function get localizationId() : String
      {
         return "roomItem.name." + UnknownVarFromFurnitureOffer_IFurnitureData_1.id;
      }
      
      public function get bundlePurchaseAllowed() : Boolean
      {
         return false;
      }
      
      public function get isRentOffer() : Boolean
      {
         if(UnknownVarFromFurnitureOffer_Int_1 > -1)
         {
            return UnknownVarFromFurnitureOffer_Boolean_1;
         }
         return UnknownVarFromFurnitureOffer_IFurnitureData_1.rentOfferId > -1 && !(_page != null && _page.isBuilderPage);
      }
      
      public function get giftable() : Boolean
      {
         return false;
      }
      
      public function get pricingModel() : String
      {
         return "pricing_model_furniture";
      }
      
      public function set previewCallbackId(param1:int) : void
      {
         _previewCallbackId = param1;
      }
      
      public function get previewCallbackId() : int
      {
         return _previewCallbackId;
      }
      
      public function get clubLevel() : int
      {
         return 0;
      }
      
      public function get badgeCode() : String
      {
         return "";
      }
      
      public function get extraChatStyleCode() : String
      {
         return "";
      }
      
      public function get isSingleChatStyle() : Boolean
      {
         return false;
      }
      
      public function set page(param1:ICatalogPage) : void
      {
         _page = param1;
      }
      
      public function get localizationName() : String
      {
         var _loc1_:IProductData = !!_product ? _product.productData : null;
         if(_loc1_ != null && _loc1_.name != null && _loc1_.name.length > 0)
         {
            return _loc1_.name;
         }
         return UnknownVarFromFurnitureOffer_IFurnitureData_1.localizedName;
      }
      
      public function get localizationDescription() : String
      {
         return UnknownVarFromFurnitureOffer_IFurnitureData_1.description;
      }
      
      public function get priceInSilver() : int
      {
         return -1;
      }
      
      public function get priceInEmerald() : int
      {
         return 0;
      }
   }
}

