package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.session.product.IProductData;
   
   public class ClubGiftConfirmationDialog
   {
      private var _offer:UnknownIHabboCatalog1;
      
      private var UnknownVarFromClubGiftConfirmationDialog_ClubGiftController_1:ClubGiftController;
      
      private var UnknownVarFromClubGiftConfirmationDialog_IFrameController_1:IFrameController;
      
      public function ClubGiftConfirmationDialog(param1:ClubGiftController, param2:UnknownIHabboCatalog1)
      {
         super();
         _offer = param2;
         UnknownVarFromClubGiftConfirmationDialog_ClubGiftController_1 = param1;
         showConfirmation();
      }
      
      public function dispose() : void
      {
         UnknownVarFromClubGiftConfirmationDialog_ClubGiftController_1 = null;
         _offer = null;
         if(UnknownVarFromClubGiftConfirmationDialog_IFrameController_1)
         {
            UnknownVarFromClubGiftConfirmationDialog_IFrameController_1.dispose();
            UnknownVarFromClubGiftConfirmationDialog_IFrameController_1 = null;
         }
      }
      
      public function showConfirmation() : void
      {
         if(!_offer || !UnknownVarFromClubGiftConfirmationDialog_ClubGiftController_1)
         {
            return;
         }
         UnknownVarFromClubGiftConfirmationDialog_IFrameController_1 = createWindow("club_gift_confirmation") as IFrameController;
         if(!UnknownVarFromClubGiftConfirmationDialog_IFrameController_1)
         {
            return;
         }
         UnknownVarFromClubGiftConfirmationDialog_IFrameController_1.procedure = windowEventHandler;
         UnknownVarFromClubGiftConfirmationDialog_IFrameController_1.center();
         var _loc2_:ITextWindow = UnknownVarFromClubGiftConfirmationDialog_IFrameController_1.findChildByName("item_name") as ITextWindow;
         if(_loc2_)
         {
            _loc2_.text = getProductName();
         }
         var _loc1_:IWindowController_1 = UnknownVarFromClubGiftConfirmationDialog_IFrameController_1.findChildByName("image_border") as IWindowController_1;
         if(!_loc1_)
         {
            return;
         }
         if(!_offer.productContainer)
         {
            return;
         }
         _offer.productContainer.view = _loc1_;
         _offer.productContainer.initProductIcon(UnknownVarFromClubGiftConfirmationDialog_ClubGiftController_1.roomEngine);
      }
      
      private function getProductName() : String
      {
         var _loc1_:IProductData = null;
         if(_offer && _offer.product)
         {
            _loc1_ = _offer.product.productData;
            if(_loc1_)
            {
               return _loc1_.name;
            }
         }
         return "";
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(!param1 || !param2 || !UnknownVarFromClubGiftConfirmationDialog_ClubGiftController_1 || !_offer)
         {
            return;
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "select_button":
               UnknownVarFromClubGiftConfirmationDialog_ClubGiftController_1.confirmSelection(_offer.localizationId);
               break;
            case "header_button_close":
            case "cancel_button":
               UnknownVarFromClubGiftConfirmationDialog_ClubGiftController_1.closeConfirmation();
         }
      }
      
      private function createWindow(param1:String) : IWindowModel
      {
         if(!UnknownVarFromClubGiftConfirmationDialog_ClubGiftController_1 || !UnknownVarFromClubGiftConfirmationDialog_ClubGiftController_1.assets || !UnknownVarFromClubGiftConfirmationDialog_ClubGiftController_1.windowManager)
         {
            return null;
         }
         var _loc3_:XmlAsset = UnknownVarFromClubGiftConfirmationDialog_ClubGiftController_1.assets.getAssetByName(param1) as XmlAsset;
         if(!_loc3_ || !_loc3_.content)
         {
            return null;
         }
         var _loc2_:XML = _loc3_.content as XML;
         if(!_loc2_)
         {
            return null;
         }
         return UnknownVarFromClubGiftConfirmationDialog_ClubGiftController_1.windowManager.buildFromXML(_loc2_);
      }
   }
}

