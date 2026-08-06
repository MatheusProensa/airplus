package com.sulake.habbo.ui.widget.furniture.mysterybox
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.mysterybox.CancelMysteryBoxWaitMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.mysterybox.GotMysteryBoxPrizeMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.mysterybox.ShowMysteryBoxWaitMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.mysterybox.MysteryBoxWaitingCanceledMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   import com.sulake.habbo.communication.messages.parser.mysterybox.GotMysteryBoxPrizeMessageParser;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   import com.sulake.habbo.window.utils.IModalDialog;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class MysteryBoxOpenDialogView implements IComponentInterfaceQueue, UnknownIHabboRoom1
   {
      private var _disposed:Boolean;
      
      private var UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1:FurnitureContextMenuWidget;
      
      private var UnknownVarFromMysteryBoxOpenDialogView_IModalDialog_1:IModalDialog;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromMysteryBoxOpenDialogView_IRoomObject_1:IRoomObject;
      
      private var UnknownVarFromMysteryBoxOpenDialogView_ShowMysteryBoxWaitMessageEvent_1:ShowMysteryBoxWaitMessageEvent;
      
      private var UnknownVarFromMysteryBoxOpenDialogView_CancelMysteryBoxWaitMessageEvent_1:CancelMysteryBoxWaitMessageEvent;
      
      private var UnknownVarFromMysteryBoxOpenDialogView_GotMysteryBoxPrizeMessageEvent_1:GotMysteryBoxPrizeMessageEvent;
      
      private var UnknownVarFromMysteryBoxOpenDialogView_Int_1:int = -1;
      
      public function MysteryBoxOpenDialogView(param1:FurnitureContextMenuWidget)
      {
         super();
         UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1 = param1;
         UnknownVarFromMysteryBoxOpenDialogView_ShowMysteryBoxWaitMessageEvent_1 = new ShowMysteryBoxWaitMessageEvent(onShowMysteryBoxWait);
         UnknownVarFromMysteryBoxOpenDialogView_CancelMysteryBoxWaitMessageEvent_1 = new CancelMysteryBoxWaitMessageEvent(onCancelMysteryBoxWait);
         UnknownVarFromMysteryBoxOpenDialogView_GotMysteryBoxPrizeMessageEvent_1 = new GotMysteryBoxPrizeMessageEvent(onGotMysteryBoxPrize);
         var _loc2_:IConnection = connection;
         if(_loc2_ != null)
         {
            _loc2_.addMessageEvent(UnknownVarFromMysteryBoxOpenDialogView_ShowMysteryBoxWaitMessageEvent_1);
            _loc2_.addMessageEvent(UnknownVarFromMysteryBoxOpenDialogView_CancelMysteryBoxWaitMessageEvent_1);
            _loc2_.addMessageEvent(UnknownVarFromMysteryBoxOpenDialogView_GotMysteryBoxPrizeMessageEvent_1);
         }
      }
      
      private function onShowMysteryBoxWait(param1:ShowMysteryBoxWaitMessageEvent) : void
      {
         showWaitWindow();
      }
      
      private function onCancelMysteryBoxWait(param1:CancelMysteryBoxWaitMessageEvent) : void
      {
         closeWindow();
      }
      
      private function onGotMysteryBoxPrize(param1:GotMysteryBoxPrizeMessageEvent) : void
      {
         var _loc2_:GotMysteryBoxPrizeMessageParser = param1.getParser();
         showRewardWindow(_loc2_.contentType,_loc2_.classId);
      }
      
      private function showWaitWindow() : void
      {
         closeWindow();
         var _loc1_:XML = UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.assets.getAssetByName("mystery_box_open_dialog").content as XML;
         UnknownVarFromMysteryBoxOpenDialogView_IModalDialog_1 = UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.handler.container.windowManager.buildModalDialogFromXML(_loc1_);
         _window = UnknownVarFromMysteryBoxOpenDialogView_IModalDialog_1.rootWindow as IWindowController_1;
         _window.procedure = waitWindowProcedure;
         var _loc4_:Boolean = UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.handler.container.isOwnerOfFurniture(UnknownVarFromMysteryBoxOpenDialogView_IRoomObject_1);
         var _loc5_:String = _loc4_ ? "mysterybox.dialog.owner." : "mysterybox.dialog.other.";
         _window.caption = "${" + _loc5_ + "title}";
         _window.findChildByName("subtitle_text").caption = "${" + _loc5_ + "subtitle}";
         _window.findChildByName("waiting_text").caption = "${" + _loc5_ + "waiting}";
         _window.findChildByName("cancel_button").caption = "${" + _loc5_ + "cancel}";
         IStaticBitmapWrapperWindow(_window.findChildByName("reward_base")).assetUri = _loc4_ ? "mysterybox_box_base" : "mysterybox_key_base";
         IStaticBitmapWrapperWindow(_window.findChildByName("reward_overlay")).assetUri = _loc4_ ? "mysterybox_box_overlay" : "mysterybox_key_overlay";
         IStaticBitmapWrapperWindow(_window.findChildByName("needed_base")).assetUri = _loc4_ ? "mysterybox_key_base" : "mysterybox_box_base";
         IStaticBitmapWrapperWindow(_window.findChildByName("needed_overlay")).assetUri = _loc4_ ? "mysterybox_key_overlay" : "mysterybox_box_overlay";
         var _loc6_:ISessionDataManager = UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.handler.container.sessionDataManager;
         var _loc2_:String = _loc4_ ? _loc6_.mysteryBoxColor : _loc6_.mysteryKeyColor;
         if(_loc2_ == null || _loc2_ == "")
         {
            return;
         }
         var _loc3_:uint = uint(MysteryBoxToolbarExtension.KEY_COLORS[_loc2_.toLowerCase()]);
         _window.findChildByName("reward_base").color = _loc3_;
         _window.findChildByName("needed_base").color = _loc3_;
      }
      
      private function waitWindowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:IConnection = null;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_button":
               closeWindow();
               _loc3_ = connection;
               if(_loc3_ != null)
               {
                  _loc3_.send(new MysteryBoxWaitingCanceledMessageComposer(UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.handler.container.getFurnitureOwnerId(UnknownVarFromMysteryBoxOpenDialogView_IRoomObject_1)));
               }
         }
      }
      
      private function showRewardWindow(param1:String, param2:int) : void
      {
         closeWindow();
         var _loc3_:XML = UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.assets.getAssetByName("mystery_box_reward").content as XML;
         UnknownVarFromMysteryBoxOpenDialogView_IModalDialog_1 = UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.handler.container.windowManager.buildModalDialogFromXML(_loc3_);
         _window = UnknownVarFromMysteryBoxOpenDialogView_IModalDialog_1.rootWindow as IWindowController_1;
         _window.procedure = rewardWindowProcedure;
         UnknownVarFromMysteryBoxOpenDialogView_Int_1 = -1;
         var _loc4_:UnknownHabboRoom1 = null;
         switch(param1)
         {
            case "s":
               _loc4_ = UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.handler.container.roomEngine.getFurnitureImage(param2,new Vector3d(90,0,0),64,this,0);
               break;
            case "i":
               _loc4_ = UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.handler.container.roomEngine.getWallItemImage(param2,new Vector3d(90,0,0),64,this,0);
               break;
            case "e":
               rewardBitmap = UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.handler.container.catalog.getPixelEffectIcon(param2);
               break;
            case "h":
               rewardBitmap = UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.handler.container.catalog.getSubscriptionProductIcon(param2);
               break;
            default:
               return;
         }
         if(_loc4_ != null)
         {
            if(_loc4_.data != null)
            {
               rewardBitmap = _loc4_.data;
            }
            UnknownVarFromMysteryBoxOpenDialogView_Int_1 = _loc4_.id;
         }
      }
      
      private function set rewardBitmap(param1:BitmapData) : void
      {
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:IBitmapWrapperController = _window.findChildByName("reward_image") as IBitmapWrapperController;
         var _loc2_:IWindowModel = _window.findChildByName("bitmap_container");
         _loc3_.bitmap = param1;
         _loc2_.width = param1.width;
         _loc2_.height = param1.height;
         _loc2_.width++;
      }
      
      private function rewardWindowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param1.target.name)
         {
            case "header_button_close":
            case "close_button":
               closeWindow();
         }
      }
      
      private function closeWindow() : void
      {
         if(UnknownVarFromMysteryBoxOpenDialogView_IModalDialog_1 != null && !UnknownVarFromMysteryBoxOpenDialogView_IModalDialog_1.disposed)
         {
            _window = null;
            UnknownVarFromMysteryBoxOpenDialogView_IModalDialog_1.dispose();
            UnknownVarFromMysteryBoxOpenDialogView_IModalDialog_1 = null;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         closeWindow();
         var _loc1_:IConnection = connection;
         if(_loc1_ != null)
         {
            _loc1_.removeMessageEvent(UnknownVarFromMysteryBoxOpenDialogView_ShowMysteryBoxWaitMessageEvent_1);
            _loc1_.removeMessageEvent(UnknownVarFromMysteryBoxOpenDialogView_CancelMysteryBoxWaitMessageEvent_1);
            _loc1_.removeMessageEvent(UnknownVarFromMysteryBoxOpenDialogView_GotMysteryBoxPrizeMessageEvent_1);
         }
         UnknownVarFromMysteryBoxOpenDialogView_ShowMysteryBoxWaitMessageEvent_1 = null;
         UnknownVarFromMysteryBoxOpenDialogView_CancelMysteryBoxWaitMessageEvent_1 = null;
         UnknownVarFromMysteryBoxOpenDialogView_GotMysteryBoxPrizeMessageEvent_1 = null;
         UnknownVarFromMysteryBoxOpenDialogView_IRoomObject_1 = null;
         UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function startOpenFlow(param1:IRoomObject) : void
      {
         UnknownVarFromMysteryBoxOpenDialogView_IRoomObject_1 = param1;
         var _loc2_:IConnection = connection;
         if(_loc2_ != null)
         {
            _loc2_.send(new UseFurnitureMessageComposer(param1.getId()));
         }
      }
      
      private function get connection() : IConnection
      {
         if(UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1 == null || UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.handler == null || UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.handler.container == null)
         {
            return null;
         }
         return UnknownVarFromMysteryBoxOpenDialogView_FurnitureContextMenuWidget_1.handler.container.connection;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(param1 == UnknownVarFromMysteryBoxOpenDialogView_Int_1)
         {
            UnknownVarFromMysteryBoxOpenDialogView_Int_1 = -1;
            rewardBitmap = param2;
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}

