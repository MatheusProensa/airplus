package com.sulake.habbo.ui.widget.furniture.mysterytrophy
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.OpenMysteryTrophyMessageComposer;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class MysteryTrophyOpenDialogView implements IComponentInterfaceQueue
   {
      private static const UnknownConstFromMysteryTrophyOpenDialogView_String_1:String = "header_button_close";
      
      private static const UnknownConstFromMysteryTrophyOpenDialogView_String_2:String = "cancel";
      
      private static const UnknownConstFromMysteryTrophyOpenDialogView_String_3:String = "ok";
      
      private var _window:IWindowController_1;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromMysteryTrophyOpenDialogView_FurnitureContextMenuWidget_1:FurnitureContextMenuWidget;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromMysteryTrophyOpenDialogView_Int_1:int;
      
      public function MysteryTrophyOpenDialogView(param1:FurnitureContextMenuWidget)
      {
         super();
         UnknownVarFromMysteryTrophyOpenDialogView_FurnitureContextMenuWidget_1 = param1;
         _windowManager = param1.windowManager;
         _assets = UnknownVarFromMysteryTrophyOpenDialogView_FurnitureContextMenuWidget_1.assets;
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
         UnknownVarFromMysteryTrophyOpenDialogView_Int_1 = param1;
         setWindowContent();
         _window.visible = true;
      }
      
      private function setWindowContent() : void
      {
         var _loc1_:String = null;
         if(!_window)
         {
            _loc1_ = "mysterytrophy_xml";
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
         var _loc2_:String = null;
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel":
               close();
               break;
            case "ok":
               _loc2_ = getTrophyInscription();
               connection.send(new OpenMysteryTrophyMessageComposer(UnknownVarFromMysteryTrophyOpenDialogView_Int_1,_loc2_));
               close();
         }
      }
      
      private function getTrophyInscription() : String
      {
         var _loc1_:ITextFieldWindow = null;
         if(_window)
         {
            _loc1_ = _window.findChildByName("input") as ITextFieldWindow;
            if(_loc1_)
            {
               return _loc1_.text;
            }
         }
         return null;
      }
      
      private function get connection() : IConnection
      {
         return UnknownVarFromMysteryTrophyOpenDialogView_FurnitureContextMenuWidget_1.handler.container.connection;
      }
   }
}

