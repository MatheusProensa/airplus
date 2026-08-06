package com.sulake.habbo.nux
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGift;
   import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGiftOptions;
   import com.sulake.habbo.communication.messages.incoming.nux.NewUserExperienceGiftProduct;
   import com.sulake.habbo.communication.messages.outgoing.nux.NewUserExperienceGetGiftsSelection;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.session.product.UnknownIHabboSessionProduct1;
   
   public class NuxGiftSelectionView implements UnknownIHabboSessionProduct1
   {
      private var _frame:IFrameController;
      
      private var UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1:HabboNuxDialogs;
      
      private var UnknownVarFromNuxGiftSelectionView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromNuxGiftSelectionView_Vector_1:Vector.<NewUserExperienceGiftOptions>;
      
      private var UnknownVarFromNuxGiftSelectionView_Int_1:int;
      
      private var UnknownVarFromNuxGiftSelectionView_Vector_2:Vector.<NewUserExperienceGetGiftsSelection>;
      
      public function NuxGiftSelectionView(param1:HabboNuxDialogs, param2:Vector.<NewUserExperienceGiftOptions>)
      {
         super();
         UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1 = param1;
         UnknownVarFromNuxGiftSelectionView_Vector_1 = param2;
         UnknownVarFromNuxGiftSelectionView_Int_1 = 0;
         UnknownVarFromNuxGiftSelectionView_Vector_2 = new Vector.<NewUserExperienceGetGiftsSelection>();
         if(UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1.sessionDataManager && UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1.sessionDataManager.loadProductData(this))
         {
            show();
         }
      }
      
      public function productDataReady() : void
      {
         show();
      }
      
      public function dispose() : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
         UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1 = null;
         UnknownVarFromNuxGiftSelectionView_IWindowController_1_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1 == null;
      }
      
      private function hide() : void
      {
         if(UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1)
         {
            UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1.destroyNuxOfferView();
         }
      }
      
      private function show() : void
      {
         if(_frame != null)
         {
            _frame.dispose();
         }
         var _loc2_:XmlAsset = UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1.assets.getAssetByName("nux_gift_selection_xml") as XmlAsset;
         _frame = UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1.windowManager.buildFromXML(_loc2_.content as XML) as IFrameController;
         if(_frame == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var _loc1_:IWindowModel = _frame.findChildByTag("close");
         if(_loc1_)
         {
            _loc1_.visible = false;
         }
         populateStep();
      }
      
      private function populateStep() : void
      {
         var _loc6_:int = 0;
         var _loc2_:NewUserExperienceGift = null;
         var _loc12_:IWindowController_1 = null;
         var _loc3_:ITextWindow = null;
         var _loc9_:UnknownICoreWindowComponents4 = null;
         var _loc10_:IWindowController_1 = null;
         var _loc14_:IStaticBitmapWrapperWindow = null;
         var _loc13_:String = null;
         var _loc15_:int = 0;
         var _loc4_:NewUserExperienceGiftProduct = null;
         var _loc16_:String = null;
         var _loc8_:String = null;
         var _loc11_:IProductData = null;
         var _loc17_:String = null;
         if(!UnknownVarFromNuxGiftSelectionView_Vector_1 || !UnknownVarFromNuxGiftSelectionView_Vector_1.length)
         {
            return;
         }
         var _loc1_:NewUserExperienceGiftOptions = UnknownVarFromNuxGiftSelectionView_Vector_1[UnknownVarFromNuxGiftSelectionView_Int_1];
         var _loc5_:IItemListWindow = _frame.findChildByName("nux_gift_selection_list") as IItemListWindow;
         if(!UnknownVarFromNuxGiftSelectionView_IWindowController_1_1)
         {
            UnknownVarFromNuxGiftSelectionView_IWindowController_1_1 = _loc5_.getListItemAt(0) as IWindowController_1;
         }
         _loc5_.removeListItems();
         var _loc7_:String = decodeURI(UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1.localizationManager.getLocalization("nux.gift.selection.separator",", "));
         _loc6_ = 0;
         while(_loc6_ < _loc1_.options.length)
         {
            _loc2_ = _loc1_.options[_loc6_];
            _loc12_ = UnknownVarFromNuxGiftSelectionView_IWindowController_1_1.clone() as IWindowController_1;
            _loc3_ = _loc12_.getChildByName("option_heading") as ITextWindow;
            _loc9_ = _loc12_.getChildByName("option_button") as UnknownICoreWindowComponents4;
            _loc10_ = _loc12_.getChildByName("option_thumbnail") as IWindowController_1;
            _loc14_ = _loc10_.getChildByName("option_bitmap") as IStaticBitmapWrapperWindow;
            _loc13_ = "";
            if(_loc2_.productOfferList.length)
            {
               _loc15_ = 0;
               while(_loc15_ < _loc2_.productOfferList.length)
               {
                  _loc4_ = _loc2_.productOfferList[_loc15_];
                  _loc16_ = _loc4_.productCode;
                  _loc8_ = _loc4_.localizationKey;
                  if(_loc8_ != null)
                  {
                     _loc13_ += UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1.localizationManager.getLocalization(_loc8_,_loc8_);
                  }
                  else
                  {
                     _loc11_ = UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1.catalog.getProductData(_loc16_);
                     if(_loc11_ && _loc11_.name)
                     {
                        _loc13_ += _loc11_.name;
                     }
                     else
                     {
                        _loc13_ += UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1.localizationManager.getLocalization("product_" + _loc16_ + "_name","product_" + _loc16_ + "_name");
                     }
                  }
                  if(_loc15_ < _loc2_.productOfferList.length - 1)
                  {
                     _loc13_ += _loc7_;
                  }
                  _loc15_++;
               }
            }
            _loc17_ = _loc2_.thumbnailUrl;
            if(_loc17_)
            {
               _loc14_.assetUri = UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1.configuration.getProperty("image.library.url") + _loc17_;
            }
            _loc3_.text = _loc13_;
            _loc9_.name = _loc6_.toString();
            _loc9_.procedure = onSelectOption;
            _loc5_.addListItem(_loc12_);
            _loc6_++;
         }
         _loc5_.arrangeListItems();
         if(UnknownVarFromNuxGiftSelectionView_Vector_1.length > 1)
         {
            _frame.caption = UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1.localizationManager.getLocalization("nux.gift.selection.title") + " " + (UnknownVarFromNuxGiftSelectionView_Int_1 + 1) + "/" + UnknownVarFromNuxGiftSelectionView_Vector_1.length;
         }
         _frame.center();
      }
      
      private function onSelectOption(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:NewUserExperienceGiftOptions = null;
         var _loc6_:IItemListWindow = null;
         var _loc4_:int = 0;
         var _loc5_:NewUserExperienceGetGiftsSelection = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = UnknownVarFromNuxGiftSelectionView_Vector_1[UnknownVarFromNuxGiftSelectionView_Int_1];
            _loc6_ = _frame.findChildByName("nux_gift_selection_list") as IItemListWindow;
            _loc4_ = _loc6_.getListItemIndex(param2.parent);
            if(_loc4_ == -1)
            {
               return;
            }
            _loc5_ = new NewUserExperienceGetGiftsSelection(_loc3_.dayIndex,_loc3_.stepIndex,_loc4_);
            UnknownVarFromNuxGiftSelectionView_Vector_2.push(_loc5_);
            UnknownVarFromNuxGiftSelectionView_Int_1++;
            if(UnknownVarFromNuxGiftSelectionView_Int_1 == UnknownVarFromNuxGiftSelectionView_Vector_1.length)
            {
               UnknownVarFromNuxGiftSelectionView_HabboNuxDialogs_1.onSendGetGifts(UnknownVarFromNuxGiftSelectionView_Vector_2);
            }
            else
            {
               show();
            }
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
   }
}

