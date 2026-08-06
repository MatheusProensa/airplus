package com.sulake.habbo.ui.widget.furniture.effectbox
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class EffectBoxOpenDialogView implements IComponentInterfaceQueue
   {
      private static const UnknownConstFromEffectBoxOpenDialogView_String_1:String = "header_button_close";
      
      private static const UnknownConstFromEffectBoxOpenDialogView_String_2:String = "cancel";
      
      private static const UnknownConstFromEffectBoxOpenDialogView_String_3:String = "ok";
      
      private var _window:IWindowController_1;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromEffectBoxOpenDialogView_FurnitureContextMenuWidget_1:FurnitureContextMenuWidget;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromEffectBoxOpenDialogView_Int_1:int;
      
      public function EffectBoxOpenDialogView(param1:FurnitureContextMenuWidget)
      {
         super();
         UnknownVarFromEffectBoxOpenDialogView_FurnitureContextMenuWidget_1 = param1;
         _windowManager = param1.windowManager;
         _assets = UnknownVarFromEffectBoxOpenDialogView_FurnitureContextMenuWidget_1.assets;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _disposed = true;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function open(param1:int) : void
      {
         UnknownVarFromEffectBoxOpenDialogView_Int_1 = param1;
         setWindowContent();
         _window.visible = true;
      }
      
      private function setWindowContent() : void
      {
         var _loc1_:String = null;
         if(!_window)
         {
            _loc1_ = "effectbox_xml";
            _window = _windowManager.buildFromXML(_assets.getAssetByName(_loc1_).content as XML) as IWindowController_1;
            addClickListener("ok");
            addClickListener("cancel");
            addClickListener("header_button_close");
            _window.center();
         }
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function addClickListener(param1:String) : void
      {
         _window.findChildByName(param1).addEventListener("WME_CLICK",onMouseClick);
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:* = null;
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel":
               close();
               break;
            case "ok":
               connection.send(new UseFurnitureMessageComposer(UnknownVarFromEffectBoxOpenDialogView_Int_1));
               close();
         }
         if(_loc2_)
         {
            UnknownVarFromEffectBoxOpenDialogView_FurnitureContextMenuWidget_1.messageListener.processWidgetMessage(_loc2_);
         }
      }
      
      private function get connection() : IConnection
      {
         return UnknownVarFromEffectBoxOpenDialogView_FurnitureContextMenuWidget_1.handler.container.connection;
      }
   }
}

