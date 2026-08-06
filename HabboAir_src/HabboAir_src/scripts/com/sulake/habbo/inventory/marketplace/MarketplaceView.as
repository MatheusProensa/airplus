package com.sulake.habbo.inventory.marketplace
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.catalog.marketplace.MarketplaceItemStats;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemGridOverlayWidget;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.system.System;
   
   public class MarketplaceView implements UnknownIHabboRoom1
   {
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromMarketplaceView_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var UnknownVarFromMarketplaceView_IFrameController_1:IFrameController;
      
      private var UnknownVarFromMarketplaceView_MarketplaceModel_1:MarketplaceModel;
      
      private var _roomEngine:IRoomEngine;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromMarketplaceView_Int_1:int;
      
      private var UnknownVarFromMarketplaceView_Int_2:int;
      
      private var _offerAmount:int = 1;
      
      private var _maxOfferAmount:int = 1;
      
      private var _furniName:String;
      
      private var UnknownVarFromMarketplaceView_HabboInventory_1:HabboInventory;
      
      private var UnknownVarFromMarketplaceView_Int_3:int;
      
      public function MarketplaceView(param1:MarketplaceModel, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IRoomEngine, param5:IHabboLocalizationManager, param6:HabboInventory)
      {
         super();
         UnknownVarFromMarketplaceView_MarketplaceModel_1 = param1;
         UnknownVarFromMarketplaceView_IAssetLibraryCollection_1 = param3;
         _windowManager = param2;
         _roomEngine = param4;
         _localization = param5;
         UnknownVarFromMarketplaceView_HabboInventory_1 = param6;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            UnknownVarFromMarketplaceView_MarketplaceModel_1 = null;
            UnknownVarFromMarketplaceView_IAssetLibraryCollection_1 = null;
            _windowManager = null;
            _roomEngine = null;
            _localization = null;
            disposeView();
            _disposed = true;
         }
      }
      
      private function disposeView() : void
      {
         if(UnknownVarFromMarketplaceView_IFrameController_1 != null)
         {
            UnknownVarFromMarketplaceView_IFrameController_1.dispose();
            UnknownVarFromMarketplaceView_IFrameController_1 = null;
         }
      }
      
      public function showBuyTokens(param1:int, param2:int) : void
      {
         if(_localization)
         {
            _localization.registerParameter("inventory.marketplace.buy_tokens.info","price",param1.toString());
            _localization.registerParameter("inventory.marketplace.buy_tokens.info","count",param2.toString());
            _localization.registerParameter("inventory.marketplace.buy_tokens.info","free",(param2 - 1).toString());
            _localization.registerParameter("inventory.marketplace.buy_tokens.buy","price",param1.toString());
         }
         UnknownVarFromMarketplaceView_IFrameController_1 = createWindow("buy_marketplace_tokens_xml") as IFrameController;
         if(UnknownVarFromMarketplaceView_IFrameController_1 == null)
         {
            return;
         }
         UnknownVarFromMarketplaceView_IFrameController_1.procedure = clickHandler;
         UnknownVarFromMarketplaceView_IFrameController_1.center();
      }
      
      public function showMakeOffer(param1:FurnitureItem, param2:int) : void
      {
         var _loc8_:UnknownHabboRoom1 = null;
         var _loc12_:String = null;
         var _loc5_:String = null;
         var _loc7_:IWidgetWindowController = null;
         var _loc4_:ILimitedItemPreviewOverlayWidget = null;
         var _loc11_:IWidgetWindowController = null;
         var _loc9_:IRarityItemGridOverlayWidget = null;
         if(!param1 || !_localization || !_roomEngine || !UnknownVarFromMarketplaceView_MarketplaceModel_1)
         {
            return;
         }
         _maxOfferAmount = Math.max(1,param2);
         _offerAmount = 1;
         _localization.registerParameter("sellinmarketplace.amount","max_amount",_maxOfferAmount.toString());
         UnknownVarFromMarketplaceView_IFrameController_1 = createWindow("make_marketplace_offer_xml") as IFrameController;
         if(!UnknownVarFromMarketplaceView_IFrameController_1)
         {
            return;
         }
         var _loc3_:ITextFieldWindow = UnknownVarFromMarketplaceView_IFrameController_1.findChildByName("price_input") as ITextFieldWindow;
         if(_loc3_ != null)
         {
            _loc3_.restrict = "0-9";
         }
         var _loc10_:ITextFieldWindow = UnknownVarFromMarketplaceView_IFrameController_1.findChildByName("amount_input") as ITextFieldWindow;
         if(_loc10_ != null)
         {
            _loc10_.restrict = "0-9";
            _loc10_.text = _offerAmount.toString();
         }
         checkPrice();
         _localization.registerParameter("inventory.marketplace.make_offer.expiration_info_days","days",String(UnknownVarFromMarketplaceView_MarketplaceModel_1.expirationHours / 24));
         _localization.registerParameter("inventory.marketplace.make_offer.min_price","minprice",UnknownVarFromMarketplaceView_MarketplaceModel_1.offerMinPrice.toString());
         _localization.registerParameter("inventory.marketplace.make_offer.max_price","maxprice",UnknownVarFromMarketplaceView_MarketplaceModel_1.offerMaxPrice.toString());
         var _loc6_:Number = 4293848814;
         if(!param1.isWallItem)
         {
            _loc8_ = _roomEngine.getFurnitureImage(param1.type,new Vector3d(90,0,0),64,this,_loc6_,String(param1.extra));
         }
         else
         {
            _loc8_ = _roomEngine.getWallItemImage(param1.type,new Vector3d(90,0,0),64,this,_loc6_,param1.stuffData.getLegacyString());
         }
         if(!_loc8_)
         {
            return;
         }
         UnknownVarFromMarketplaceView_Int_1 = _loc8_.id;
         setFurniImage(_loc8_.data);
         if(param1.isWallItem)
         {
            _loc12_ = "wallItem.name." + param1.type;
            _loc5_ = "wallItem.desc." + param1.type;
         }
         else
         {
            _loc12_ = "roomItem.name." + param1.type;
            _loc5_ = "roomItem.desc." + param1.type;
         }
         if(param1.category == 6)
         {
            _loc12_ = "poster_" + param1.stuffData.getLegacyString() + "_name";
            _loc5_ = "poster_" + param1.stuffData.getLegacyString() + "_desc";
         }
         _furniName = _localization.getLocalization(_loc12_);
         setText("furni_name","${" + _loc12_ + "}");
         setText("furni_desc","${" + _loc5_ + "}");
         UnknownVarFromMarketplaceView_IFrameController_1.procedure = clickHandler;
         UnknownVarFromMarketplaceView_IFrameController_1.center();
         resetPriceStats();
         if(param1.stuffData != null && param1.stuffData.uniqueSerialNumber > 0)
         {
            _loc7_ = IWidgetWindowController(UnknownVarFromMarketplaceView_IFrameController_1.findChildByName("unique_item_overlay_widget"));
            _loc7_.visible = true;
            _loc4_ = ILimitedItemPreviewOverlayWidget(_loc7_.widget);
            _loc4_.serialNumber = param1.stuffData.uniqueSerialNumber;
            _loc4_.seriesSize = param1.stuffData.uniqueSeriesSize;
         }
         if(param1.stuffData != null && param1.stuffData.rarityLevel >= 0)
         {
            _loc11_ = IWidgetWindowController(UnknownVarFromMarketplaceView_IFrameController_1.findChildByName("rarity_item_overlay_widget"));
            _loc11_.visible = true;
            _loc9_ = IRarityItemGridOverlayWidget(_loc11_.widget);
            _loc9_.rarityLevel = param1.stuffData.rarityLevel;
         }
         UnknownVarFromMarketplaceView_MarketplaceModel_1.getItemStats();
      }
      
      private function setFurniImage(param1:BitmapData) : void
      {
         if(param1 == null || UnknownVarFromMarketplaceView_IFrameController_1 == null)
         {
            return;
         }
         var _loc5_:IBitmapWrapperController = UnknownVarFromMarketplaceView_IFrameController_1.findChildByName("furni_image") as IBitmapWrapperController;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc2_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         var _loc3_:int = (_loc2_.width - param1.width) * 0.5;
         var _loc4_:int = (_loc2_.height - param1.height) * 0.5;
         _loc2_.draw(param1,new Matrix(1,0,0,1,_loc3_,_loc4_));
         _loc5_.bitmap = _loc2_;
      }
      
      private function setText(param1:String, param2:String) : void
      {
         if(UnknownVarFromMarketplaceView_IFrameController_1 == null)
         {
            return;
         }
         var _loc3_:ITextWindow = UnknownVarFromMarketplaceView_IFrameController_1.findChildByName(param1) as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = param2;
      }
      
      public function showNoCredits(param1:int) : void
      {
         if(_localization)
         {
            _localization.registerParameter("inventory.marketplace.no_credits.info","price",param1.toString());
         }
         UnknownVarFromMarketplaceView_IFrameController_1 = createWindow("marketplace_no_credits_xml") as IFrameController;
         if(UnknownVarFromMarketplaceView_IFrameController_1 == null)
         {
            return;
         }
         UnknownVarFromMarketplaceView_IFrameController_1.procedure = clickHandler;
         UnknownVarFromMarketplaceView_IFrameController_1.center();
      }
      
      private function showConfirmation() : void
      {
         var _loc3_:String = null;
         var _loc1_:int = calculateFinalPrice(UnknownVarFromMarketplaceView_Int_2);
         var _loc2_:String = "inventory.marketplace.confirm_offer.info";
         var _loc4_:* = _loc1_;
         if(_offerAmount > 1)
         {
            _loc2_ = "inventory.marketplace.confirm_offer.info.multiple";
            _loc4_ = UnknownVarFromMarketplaceView_Int_2;
         }
         if(_offerAmount > 1)
         {
            _loc3_ = _localization.getLocalizationWithParams(_loc2_,_loc2_,"amount",_offerAmount.toString(),"furniname",_furniName,"price",_loc4_.toString(),"total",(_loc1_ * _offerAmount).toString());
         }
         else
         {
            _loc3_ = _localization.getLocalizationWithParams(_loc2_,_loc2_,"furniname",_furniName,"price",_loc4_.toString());
         }
         var _loc5_:String = _localization.getLocalization("inventory.marketplace.confirm_offer.title","inventory.marketplace.confirm_offer.title");
         _windowManager.confirm(_loc5_,_loc3_,0,confirmationCallback);
      }
      
      private function confirmationCallback(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         param1.dispose();
         if(UnknownVarFromMarketplaceView_MarketplaceModel_1 == null)
         {
            return;
         }
         if(param2.type == "WE_OK")
         {
            UnknownVarFromMarketplaceView_MarketplaceModel_1.makeOffer(UnknownVarFromMarketplaceView_Int_2,_offerAmount);
         }
         UnknownVarFromMarketplaceView_MarketplaceModel_1.releaseItems();
      }
      
      private function createWindow(param1:String) : IWindowModel
      {
         if(UnknownVarFromMarketplaceView_IAssetLibraryCollection_1 == null || _windowManager == null)
         {
            return null;
         }
         var _loc2_:XmlAsset = UnknownVarFromMarketplaceView_IAssetLibraryCollection_1.getAssetByName(param1) as XmlAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         return _windowManager.buildFromXML(_loc2_.content as XML);
      }
      
      private function clickHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:ITextFieldWindow = null;
         var _loc3_:ITextFieldWindow = null;
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "buy_tokens_button":
                  UnknownVarFromMarketplaceView_MarketplaceModel_1.buyMarketplaceTokens();
                  disposeView();
                  break;
               case "cancel_buy_tokens_button":
               case "cancel_make_offer_button":
               case "cancel_no_credits_button":
               case "header_button_close":
                  UnknownVarFromMarketplaceView_MarketplaceModel_1.releaseItems();
                  disposeView();
                  break;
               case "make_offer_button":
                  _loc4_ = UnknownVarFromMarketplaceView_IFrameController_1.findChildByName("price_input") as ITextFieldWindow;
                  if(_loc4_ != null)
                  {
                     UnknownVarFromMarketplaceView_Int_2 = parseInt(_loc4_.text);
                     _offerAmount = parseOfferAmount();
                     showConfirmation();
                  }
                  disposeView();
                  break;
               case "copy_suggested_price_button":
                  if(UnknownVarFromMarketplaceView_Int_3 > 0)
                  {
                     _loc3_ = UnknownVarFromMarketplaceView_IFrameController_1.findChildByName("price_input") as ITextFieldWindow;
                     if(_loc3_ != null)
                     {
                        _loc3_.text = UnknownVarFromMarketplaceView_Int_3.toString();
                        try
                        {
                           System.setClipboard(_loc3_.text);
                        }
                        catch(error:Error)
                        {
                        }
                        checkPrice();
                     }
                  }
                  break;
               case "get_credits_button":
                  UnknownVarFromMarketplaceView_MarketplaceModel_1.releaseItems();
                  openCreditsPage();
                  disposeView();
            }
         }
         if(param1.type == "WE_CHANGE")
         {
            if(param2.name == "price_input" || param2.name == "amount_input")
            {
               checkPrice();
            }
         }
      }
      
      private function openCreditsPage() : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(UnknownVarFromMarketplaceView_HabboInventory_1.getProperty("web.shop.relativeUrl"));
      }
      
      private function calculateFinalPrice(param1:int) : int
      {
         var _loc2_:int = Math.ceil(Math.round(1000 * (param1 * (UnknownVarFromMarketplaceView_MarketplaceModel_1.sellingFeePercentage / 100 + 0.5 * param1 / UnknownVarFromMarketplaceView_MarketplaceModel_1.halfTaxLimit))) / 1000);
         return param1 - _loc2_;
      }
      
      private function checkPrice() : void
      {
         if(UnknownVarFromMarketplaceView_IFrameController_1 == null)
         {
            return;
         }
         var _loc2_:ITextFieldWindow = UnknownVarFromMarketplaceView_IFrameController_1.findChildByName("price_input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = parseInt(_loc2_.text);
         if(_loc3_ > UnknownVarFromMarketplaceView_MarketplaceModel_1.offerMaxPrice)
         {
            _loc2_.text = UnknownVarFromMarketplaceView_MarketplaceModel_1.offerMaxPrice.toString();
            _loc3_ = UnknownVarFromMarketplaceView_MarketplaceModel_1.offerMaxPrice;
         }
         _offerAmount = parseOfferAmount();
         var _loc4_:int = calculateFinalPrice(_loc3_);
         var _loc1_:UnknownICoreWindowComponents4 = UnknownVarFromMarketplaceView_IFrameController_1.findChildByName("make_offer_button") as UnknownICoreWindowComponents4;
         var _loc5_:ITextWindow = UnknownVarFromMarketplaceView_IFrameController_1.findChildByName("final_price") as ITextWindow;
         if(_loc1_ == null || _loc5_ == null)
         {
            return;
         }
         if(_loc3_ < UnknownVarFromMarketplaceView_MarketplaceModel_1.offerMinPrice)
         {
            _localization.registerParameter("shop.marketplace.invalid.price","minPrice",UnknownVarFromMarketplaceView_MarketplaceModel_1.offerMinPrice.toString());
            _localization.registerParameter("shop.marketplace.invalid.price","maxPrice",UnknownVarFromMarketplaceView_MarketplaceModel_1.offerMaxPrice.toString());
            _loc5_.text = "${shop.marketplace.invalid.price}";
            _loc1_.disable();
         }
         else
         {
            _loc5_.text = _localization.getLocalization("sell.in.marketplace.revenue.label") + ": " + _loc4_;
            _loc1_.enable();
         }
      }
      
      private function parseOfferAmount() : int
      {
         if(UnknownVarFromMarketplaceView_IFrameController_1 == null)
         {
            return 1;
         }
         var _loc2_:ITextFieldWindow = UnknownVarFromMarketplaceView_IFrameController_1.findChildByName("amount_input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return 1;
         }
         var _loc1_:int = parseInt(_loc2_.text);
         if(_loc1_ < 1)
         {
            _loc1_ = 1;
         }
         else if(_loc1_ > _maxOfferAmount)
         {
            _loc1_ = _maxOfferAmount;
         }
         _loc2_.text = _loc1_.toString();
         return _loc1_;
      }
      
      public function showResult(param1:int) : void
      {
         var _loc2_:String = null;
         if(param1 == 1)
         {
            _loc2_ = "${inventory.marketplace.result.title.success}";
         }
         else
         {
            _loc2_ = "${inventory.marketplace.result.title.failure}";
         }
         var _loc3_:String = "${inventory.marketplace.result." + param1 + "}";
         _windowManager.alert(_loc2_,_loc3_,0,closeAlert);
      }
      
      private function closeAlert(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         UnknownVarFromMarketplaceView_MarketplaceModel_1.releaseItems();
         param1.dispose();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(UnknownVarFromMarketplaceView_Int_1 == param1)
         {
            setFurniImage(param2);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function showAlert(param1:String, param2:String) : void
      {
         _windowManager.alert(param1,param2,0,closeAlert);
      }
      
      public function updateItemStats(param1:MarketplaceItemStats, param2:int) : void
      {
         if(!UnknownVarFromMarketplaceView_IFrameController_1 || !_localization || param1 == null)
         {
            return;
         }
         UnknownVarFromMarketplaceView_Int_3 = param1.suggestedPrice;
         updatePriceStatLine("average_price","inventory.marketplace.make_offer.average_price",param1.averagePrice,param2);
         updatePriceStatLine("lowest_price","inventory.marketplace.make_offer.lowest_price",param1.lowestCurrentPrice);
         updatePriceStatLine("suggested_price","inventory.marketplace.make_offer.suggested_price",param1.suggestedPrice);
         UnknownVarFromMarketplaceView_IFrameController_1.findChildByName("copy_suggested_price_button").visible = param1.suggestedPrice > 0;
      }
      
      private function resetPriceStats() : void
      {
         UnknownVarFromMarketplaceView_Int_3 = 0;
         setStatVisibility("average_price",false);
         setStatVisibility("lowest_price",false);
         setStatVisibility("suggested_price",false);
      }
      
      private function updatePriceStatLine(param1:String, param2:String, param3:int, param4:int = -1) : void
      {
         var _loc5_:ITextWindow = UnknownVarFromMarketplaceView_IFrameController_1.findChildByName(param1) as ITextWindow;
         if(_loc5_ == null || !_localization)
         {
            return;
         }
         if(param3 <= 0)
         {
            _loc5_.visible = false;
            _loc5_.text = "";
            return;
         }
         if(param4 >= 0)
         {
            _localization.registerParameter(param2,"days",param4.toString());
         }
         _localization.registerParameter(param2,"price",param3.toString());
         _loc5_.text = _localization.getLocalization(param2);
         _loc5_.visible = true;
      }
      
      private function setStatVisibility(param1:String, param2:Boolean) : void
      {
         var _loc3_:IWindowModel = UnknownVarFromMarketplaceView_IFrameController_1.findChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.visible = param2;
         }
      }
   }
}

