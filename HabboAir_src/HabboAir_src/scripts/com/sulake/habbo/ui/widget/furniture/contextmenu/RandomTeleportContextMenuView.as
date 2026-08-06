package com.sulake.habbo.ui.widget.furniture.contextmenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.ui.widget.contextmenu.UnknownIHabboUiWidgetContextmenu1;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
   
   public class RandomTeleportContextMenuView extends FurnitureContextInfoView
   {
      private var UnknownVarFromRandomTeleportContextMenuView_Int_1:int;
      
      public function RandomTeleportContextMenuView(param1:UnknownIHabboUiWidgetContextmenu1)
      {
         super(param1);
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager)
         {
            return;
         }
         if(UnknownVarFromContextInfoView_Boolean_1)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets.getAssetByName("random_teleport_menu")).content as XML;
               _window = UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager.buildFromXML(_loc1_,0) as IWindowController_1;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               _window.findChildByName("minimize").addEventListener("WME_CLICK",onMinimize);
               _window.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
               _window.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            }
            _window.findChildByName("furni_name").caption = "${furni.random_teleport.name}";
            _window.findChildByName("buttons").procedure = buttonEventProc;
            _window.visible = false;
            activeView = _window;
            UnknownVarFromContextInfoView_Boolean_2 = false;
         }
      }
      
      override protected function buttonEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(disposed || !_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               var _loc4_:* = param2.parent.name;
               if("use" === _loc4_)
               {
                  UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.messageListener.processWidgetMessage(new RoomWidgetFurniActionMessage("RWFAM_USE",_roomObject.getId(),UnknownVarFromRandomTeleportContextMenuView_Int_1));
               }
            }
            _loc3_ = true;
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_)
         {
            UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.removeView(this,false);
         }
      }
      
      public function set objectCategory(param1:int) : void
      {
         UnknownVarFromRandomTeleportContextMenuView_Int_1 = param1;
      }
   }
}

