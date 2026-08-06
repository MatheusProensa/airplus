package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   
   public class Offer implements UnknownIHabboCatalog1
   {
      public static const PRICING_MODEL_UNKNOWN:String = "pricing_model_unknown";
      
      public static const PRICING_MODEL_SINGLE:String = "pricing_model_single";
      
      public static const PRICING_MODEL_MULTI:String = "pricing_model_multi";
      
      public static const PRICING_MODEL_BUNDLE:String = "pricing_model_bundle";
      
      public static const PRICING_MODEL_FURNI:String = "pricing_model_furniture";
      
      public static const PRICE_TYPE_NONE:String = "price_type_none";
      
      public static const PRICE_TYPE_CREDITS:String = "price_type_credits";
      
      public static const PRICE_TYPE_ACTIVITYPOINTS:String = "price_type_activitypoints";
      
      public static const PRICE_TYPE_CREDITS_AND_ACTIVITYPOINTS:String = "price_type_credits_and_activitypoints";
      
      public static const PRICE_TYPE_SILVER:String = "price_type_silver";
      
      private var _pricingModel:String;
      
      private var _priceType:String;
      
      private var _offerId:int;
      
      private var _localizationId:String;
      
      private var _priceInCredits:int;
      
      private var _priceInActivityPoints:int;
      
      private var _activityPointType:int;
      
      private var _priceInSilver:int;
      
      private var _giftable:Boolean;
      
      private var _isRentOffer:Boolean;
      
      private var _page:ICatalogPage;
      
      private var _productContainer:IProductContainer;
      
      private var _disposed:Boolean = false;
      
      private var _clubLevel:int = 0;
      
      private var _badgeCode:String;
      
      private var _extraChatBubbleCode:String;
      
      private var _bundlePurchaseAllowed:Boolean = false;
      
      private var _catalog:HabboCatalog;
      
      private var _isSingleChatStyle:Boolean;
      
      private var _previewCallbackId:int;
      
      public function Offer(param1:int, param2:String, param3:Boolean, param4:int, param5:int, param6:int, param7:int, param8:Boolean, param9:int, param10:Vector.<IProduct>, param11:Boolean, param12:HabboCatalog)
      {
         super();
         _offerId = param1;
         _localizationId = param2;
         _isRentOffer = param3;
         _priceInCredits = param4;
         _priceInActivityPoints = param5;
         _activityPointType = param6;
         _priceInSilver = param7;
         _giftable = param8;
         _clubLevel = param9;
         _bundlePurchaseAllowed = param11;
         _catalog = param12;
         _isSingleChatStyle = param10.length == 1 && param10[0].productType == "chat_style" || param10.length == 2 && (param10[0].productType == "chat_style" && param10[1].productType == "b" || param10[0].productType == "b" && param10[1].productType == "chat_style");
         analyzePricingModel(param10);
         analyzePriceType();
         createProductContainer(param10);
         for each(var _loc13_ in param10)
         {
            if(_loc13_.productType == "b")
            {
               _badgeCode = _loc13_.extraParam;
               break;
            }
            if(!isSingleChatStyle && _loc13_.productType == "chat_style")
            {
               _extraChatBubbleCode = _loc13_.extraParam;
               break;
            }
         }
      }
      
      public function get clubLevel() : int
      {
         return _clubLevel;
      }
      
      public function get page() : ICatalogPage
      {
         return _page;
      }
      
      public function set page(param1:ICatalogPage) : void
      {
         _page = param1;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get localizationId() : String
      {
         return _localizationId;
      }
      
      public function get priceInCredits() : int
      {
         return _priceInCredits;
      }
      
      public function get priceInActivityPoints() : int
      {
         return _priceInActivityPoints;
      }
      
      public function get activityPointType() : int
      {
         return _activityPointType;
      }
      
      public function get priceInSilver() : int
      {
         return _priceInSilver;
      }
      
      public function get giftable() : Boolean
      {
         return _giftable;
      }
      
      public function get productContainer() : IProductContainer
      {
         return _productContainer;
      }
      
      public function get product() : IProduct
      {
         return !!_productContainer ? _productContainer.firstProduct : null;
      }
      
      public function get gridItem() : IProductGridItem
      {
         return _productContainer as IProductGridItem;
      }
      
      public function get pricingModel() : String
      {
         return _pricingModel;
      }
      
      public function get priceType() : String
      {
         return _priceType;
      }
      
      public function get previewCallbackId() : int
      {
         return _previewCallbackId;
      }
      
      public function set previewCallbackId(param1:int) : void
      {
         _previewCallbackId = param1;
      }
      
      public function get bundlePurchaseAllowed() : Boolean
      {
         return _bundlePurchaseAllowed;
      }
      
      public function get isRentOffer() : Boolean
      {
         return _isRentOffer;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _disposed = true;
         _offerId = 0;
         _localizationId = "";
         _priceInCredits = 0;
         _priceInActivityPoints = 0;
         _activityPointType = 0;
         _page = null;
         _catalog = null;
         if(_productContainer != null)
         {
            _productContainer.dispose();
            _productContainer = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function createProductContainer(param1:Vector.<IProduct>) : void
      {
         switch(_pricingModel)
         {
            case "pricing_model_single":
               _productContainer = new SingleProductContainer(this,param1,_catalog);
               break;
            case "pricing_model_multi":
               _productContainer = new MultiProductContainer(this,param1,_catalog);
               break;
            case "pricing_model_bundle":
               _productContainer = new BundleProductContainer(this,param1,_catalog);
               break;
            default:
               _productContainer = new ProductContainer(this,param1,_catalog);
               Logger.log("[Offer] Unknown pricing model" + _pricingModel);
         }
      }
      
      private function analyzePricingModel(param1:Vector.<IProduct>) : void
      {
         if(isSingleChatStyle)
         {
            _pricingModel = "pricing_model_single";
            return;
         }
         var _loc2_:Vector.<IProduct> = Product.stripAddonProducts(param1);
         if(_loc2_.length == 1)
         {
            if(_loc2_[0].productCount == 1)
            {
               _pricingModel = "pricing_model_single";
            }
            else
            {
               _pricingModel = "pricing_model_multi";
            }
         }
         else if(_loc2_.length > 1)
         {
            _pricingModel = "pricing_model_bundle";
         }
         else
         {
            _pricingModel = "pricing_model_unknown";
         }
      }
      
      public function get isSingleChatStyle() : Boolean
      {
         return _isSingleChatStyle;
      }
      
      private function analyzePriceType() : void
      {
         if(_priceInCredits > 0 && _priceInActivityPoints > 0)
         {
            _priceType = "price_type_credits_and_activitypoints";
         }
         else if(_priceInCredits > 0)
         {
            _priceType = "price_type_credits";
         }
         else if(_priceInActivityPoints > 0)
         {
            _priceType = "price_type_activitypoints";
         }
         else if(_priceInSilver > 0)
         {
            _priceType = "price_type_silver";
         }
         else
         {
            _priceType = "price_type_none";
         }
      }
      
      public function clone() : Offer
      {
         var _loc4_:IFurnitureData = null;
         var _loc2_:Product = null;
         var _loc5_:Vector.<IProduct> = new Vector.<IProduct>(0);
         var _loc6_:IProductData = _catalog.getProductData(localizationId);
         for each(var _loc3_ in _productContainer.products)
         {
            _loc4_ = _catalog.getFurnitureData(_loc3_.productClassId,_loc3_.productType);
            _loc2_ = new Product(_loc3_.productType,_loc3_.productClassId,_loc3_.extraParam,_loc3_.productCount,_loc6_,_loc4_,_catalog);
            _loc5_.push(_loc2_);
         }
         var _loc1_:Offer = new Offer(offerId,localizationId,isRentOffer,priceInCredits,priceInActivityPoints,activityPointType,priceInSilver,giftable,clubLevel,_loc5_,bundlePurchaseAllowed,_catalog);
         _loc1_.page = page;
         return _loc1_;
      }
      
      public function get badgeCode() : String
      {
         return _badgeCode;
      }
      
      public function get extraChatStyleCode() : String
      {
         return _extraChatBubbleCode;
      }
      
      public function get localizationName() : String
      {
         var _loc1_:IProductData = _catalog.getProductData(_localizationId);
         return !!_loc1_ ? _loc1_.name : "${" + _localizationId + "}";
      }
      
      public function get localizationDescription() : String
      {
         var _loc1_:IProductData = _catalog.getProductData(_localizationId);
         return !!_loc1_ ? _loc1_.description : "${" + _localizationId + "}";
      }
      
      public function get priceInEmerald() : int
      {
         return 0;
      }
   }
}

