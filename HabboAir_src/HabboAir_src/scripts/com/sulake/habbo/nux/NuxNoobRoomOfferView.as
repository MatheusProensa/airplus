package com.sulake.habbo.nux
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class NuxNoobRoomOfferView
   {
      private var _frame:IFrameController;
      
      private var UnknownVarFromNuxNoobRoomOfferView_HabboNuxDialogs_1:HabboNuxDialogs;
      
      public function NuxNoobRoomOfferView(param1:HabboNuxDialogs)
      {
         super();
         UnknownVarFromNuxNoobRoomOfferView_HabboNuxDialogs_1 = param1;
         show();
      }
      
      public function dispose() : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
         UnknownVarFromNuxNoobRoomOfferView_HabboNuxDialogs_1 = null;
      }
      
      private function hide() : void
      {
         if(UnknownVarFromNuxNoobRoomOfferView_HabboNuxDialogs_1)
         {
            UnknownVarFromNuxNoobRoomOfferView_HabboNuxDialogs_1.destroyNuxOfferView();
         }
      }
      
      private function show() : void
      {
         if(_frame != null)
         {
            return;
         }
         var _loc3_:XmlAsset = UnknownVarFromNuxNoobRoomOfferView_HabboNuxDialogs_1.assets.getAssetByName("nux_noob_room_offer_xml") as XmlAsset;
         _frame = UnknownVarFromNuxNoobRoomOfferView_HabboNuxDialogs_1.windowManager.buildFromXML(_loc3_.content as XML) as IFrameController;
         if(_frame == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         _frame.x = _frame.y = 20;
         var _loc1_:IWindowModel = _frame.findChildByName("btnGo");
         if(_loc1_)
         {
            _loc1_.addEventListener("WME_CLICK",onGo);
         }
         var _loc2_:IWindowModel = _frame.findChildByTag("close");
         if(_loc2_)
         {
            _loc2_.addEventListener("WME_CLICK",onClose);
         }
      }
      
      private function onGo(param1:WindowMouseEvent) : void
      {
         UnknownVarFromNuxNoobRoomOfferView_HabboNuxDialogs_1.context.createLinkEvent("navigator/goto/predefined_noob_lobby");
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         UnknownVarFromNuxNoobRoomOfferView_HabboNuxDialogs_1.destroyNoobRoomOfferView();
      }
   }
}

