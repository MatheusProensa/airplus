package com.sulake.habbo.nux
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class NuxOfferOldUserView
   {
      private var _frame:IFrameController;
      
      private var UnknownVarFromNuxOfferOldUserView_HabboNuxDialogs_1:HabboNuxDialogs;
      
      public function NuxOfferOldUserView(param1:HabboNuxDialogs)
      {
         super();
         UnknownVarFromNuxOfferOldUserView_HabboNuxDialogs_1 = param1;
         show();
      }
      
      public function dispose() : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
         UnknownVarFromNuxOfferOldUserView_HabboNuxDialogs_1 = null;
      }
      
      private function hide() : void
      {
         if(UnknownVarFromNuxOfferOldUserView_HabboNuxDialogs_1)
         {
            UnknownVarFromNuxOfferOldUserView_HabboNuxDialogs_1.destroyNuxOfferView();
         }
      }
      
      private function show() : void
      {
         if(_frame != null)
         {
            return;
         }
         var _loc2_:XmlAsset = UnknownVarFromNuxOfferOldUserView_HabboNuxDialogs_1.assets.getAssetByName("nux_offer_old_user_xml") as XmlAsset;
         _frame = UnknownVarFromNuxOfferOldUserView_HabboNuxDialogs_1.windowManager.buildFromXML(_loc2_.content as XML) as IFrameController;
         if(_frame == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _frame.center();
         var _loc1_:IWindowModel = _frame.findChildByTag("close");
         if(_loc1_)
         {
            _loc1_.visible = false;
         }
         _loc1_ = _frame.findChildByName("btnSkip");
         _loc1_.addEventListener("WME_CLICK",onReject);
         _loc1_ = _frame.findChildByName("btnGo");
         _loc1_.addEventListener("WME_CLICK",onVerify);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      private function onVerify(param1:WindowMouseEvent) : void
      {
         UnknownVarFromNuxOfferOldUserView_HabboNuxDialogs_1.onVerify();
         hide();
      }
      
      private function onReject(param1:WindowMouseEvent) : void
      {
         UnknownVarFromNuxOfferOldUserView_HabboNuxDialogs_1.onReject();
      }
   }
}

