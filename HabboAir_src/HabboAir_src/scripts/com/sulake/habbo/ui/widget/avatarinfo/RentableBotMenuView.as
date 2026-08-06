package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.bots.CommandBotComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveBotFromFlatMessageComposer;
   import com.sulake.habbo.communication.messages.parser.room.bots.BotSkillData;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RentableBotMenuView extends AvatarContextInfoButtonView
   {
      protected var UnknownVarFromRentableBotMenuView_RentableBotInfoData_1:RentableBotInfoData;
      
      public function RentableBotMenuView(param1:AvatarInfoWidget)
      {
         super(param1);
         UnknownVarFromContextInfoView_Boolean_5 = false;
      }
      
      public static function setup(param1:RentableBotMenuView, param2:int, param3:String, param4:int, param5:int, param6:RentableBotInfoData) : void
      {
         param1.UnknownVarFromRentableBotMenuView_RentableBotInfoData_1 = param6;
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WME_OVER",onMouseHoverEvent);
            _window.removeEventListener("WME_OUT",onMouseHoverEvent);
         }
         UnknownVarFromRentableBotMenuView_RentableBotInfoData_1 = null;
         super.dispose();
      }
      
      protected function updateButtons() : void
      {
         var _loc6_:int = 0;
         var _loc9_:Array = null;
         var _loc4_:IWindowController_1 = null;
         var _loc10_:int = 0;
         if(!_window || !UnknownVarFromRentableBotMenuView_RentableBotInfoData_1)
         {
            return;
         }
         var _loc2_:IItemListWindow = _window.findChildByName("buttons") as IItemListWindow;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:IWindowController_1 = UnknownVarFromButtonMenuView_IItemListWindow_1.getListItemByName("link_template") as IWindowController_1;
         var _loc1_:IWindowController_1 = UnknownVarFromButtonMenuView_IItemListWindow_1.getListItemByName("nux_proceed_1") as IWindowController_1;
         _loc2_.procedure = buttonEventProc;
         _loc2_.autoArrangeItems = false;
         var _loc5_:int = _loc2_.numListItems;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_.getListItemAt(_loc6_).visible = false;
            _loc6_++;
         }
         var _loc7_:Boolean = UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.amIOwner || UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.amIAnyRoomController;
         showButton("pick",!UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.botSkills ? _loc7_ : UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.botSkills.indexOf(12) == -1 && _loc7_);
         if(UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.botSkills)
         {
            showButton("donate_to_all",UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.botSkills.indexOf(25) != -1);
            showButton("donate_to_user",UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.botSkills.indexOf(24) != -1);
            if(UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.amIOwner)
            {
               showButton("change_bot_name",UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.botSkills.indexOf(5) != -1);
               showButton("dress_up",UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.botSkills.indexOf(1) != -1);
               showButton("random_walk",UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.botSkills.indexOf(3) != -1);
               showButton("setup_chat",UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.botSkills.indexOf(2) != -1);
               showButton("dance",UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.botSkills.indexOf(4) != -1);
            }
            showButton("nux_take_tour",UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.botSkills.indexOf(10) != -1);
         }
         showButton("wired_inspect",widget.handler.container.userDefinedRoomEvents.showInspectButton());
         for each(var _loc8_ in UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.botSkillsWithCommands)
         {
            if(_loc8_.id == 7)
            {
               _loc4_ = _loc3_.clone() as IWindowController_1;
               _loc9_ = _loc8_.data.split(",");
               if(_loc9_.length == 2)
               {
                  _loc4_.findChildByName("label").caption = _loc9_[0];
                  _loc4_.name = ":link " + _loc9_[1];
                  _loc4_.visible = true;
                  _loc2_.addListItem(_loc4_);
               }
            }
            if(_loc8_.id == 8)
            {
               if(_loc8_.data == "")
               {
                  showButton("nux_proceed_1",true);
               }
               else
               {
                  _loc9_ = _loc8_.data.split(",");
                  if(_loc9_.length == 2)
                  {
                     _loc10_ = parseInt(_loc9_[1]);
                     if(_loc10_ == 1)
                     {
                        showButton("nux_proceed_1",true);
                        IWindowController_1(_loc2_.getListItemByName("nux_proceed_1")).findChildByName("label").caption = _loc9_[0];
                     }
                     else
                     {
                        _loc4_ = _loc1_.clone() as IWindowController_1;
                        _loc4_.visible = true;
                        _loc4_.name = "nux_proceed_" + _loc10_;
                        _loc4_.findChildByName("label").caption = _loc9_[0];
                        _loc2_.addListItemAt(_loc4_,_loc2_.getListItemIndex(_loc2_.getListItemByName("nux_proceed_1")) + _loc10_ - 1);
                     }
                  }
               }
            }
            if(_loc8_.id == 14)
            {
               _loc4_ = _loc3_.clone() as IWindowController_1;
               _loc9_ = _loc8_.data.split(",");
               if(_loc9_.length == 2)
               {
                  _loc4_.findChildByName("label").caption = _loc9_[0];
                  _loc4_.name = ":link navigator/search/" + _loc9_[1];
                  _loc4_.visible = true;
                  _loc2_.addListItem(_loc4_);
               }
            }
         }
         _loc2_.autoArrangeItems = true;
         _loc2_.visible = true;
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
               _loc1_ = XmlAsset(UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets.getAssetByName("avatar_menu_widget")).content as XML;
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
            UnknownVarFromButtonMenuView_IItemListWindow_1 = _window.findChildByName("buttons") as IItemListWindow;
            UnknownVarFromButtonMenuView_IItemListWindow_1.procedure = buttonEventProc;
            _window.findChildByName("name").caption = _userName;
            _window.visible = false;
            activeView = _window;
            updateButtons();
         }
      }
      
      override protected function buttonEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:Point = null;
         var _loc5_:Rectangle = null;
         var _loc6_:RoomWidgetMessage = null;
         var _loc8_:String = null;
         var _loc7_:String = null;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc5_ = null;
               switch(param2.parent.name)
               {
                  case "pick":
                     _loc3_ = true;
                     widget.handler.container.connection.send(new RemoveBotFromFlatMessageComposer(UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.id));
                     break;
                  case "setup_chat":
                     _loc3_ = true;
                     _loc5_ = new Rectangle();
                     _window.getGlobalRectangle(_loc5_);
                     _loc4_ = new Point(_loc5_.x + _loc5_.width / 2,_loc5_.y + _loc5_.height);
                     widget.openBotSkillConfigurationView(UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.id,2,_loc4_);
                     break;
                  case "random_walk":
                     _loc3_ = true;
                     widget.handler.container.connection.send(new CommandBotComposer(UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.id,3,""));
                     break;
                  case "dress_up":
                     _loc3_ = true;
                     widget.handler.container.connection.send(new CommandBotComposer(UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.id,1,""));
                     break;
                  case "dance":
                     _loc3_ = true;
                     widget.handler.container.connection.send(new CommandBotComposer(UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.id,4,""));
                     break;
                  case "donate_to_all":
                     _loc3_ = true;
                     widget.handler.container.connection.send(new CommandBotComposer(UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.id,25,""));
                     break;
                  case "donate_to_user":
                     _loc3_ = true;
                     widget.handler.container.connection.send(new CommandBotComposer(UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.id,24,""));
                     break;
                  case "nux_take_tour":
                     _loc3_ = true;
                     widget.component.context.createLinkEvent("help/tour");
                     widget.handler.container.connection.send(new CommandBotComposer(UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.id,10,""));
                     break;
                  case "wired_inspect":
                     _loc3_ = true;
                     _loc6_ = new RoomWidgetUserActionMessage("RWUAM_WIRED_INSPECT_BOT",UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.id);
                     widget.messageListener.processWidgetMessage(_loc6_);
                     break;
                  case "change_bot_name":
                     _loc3_ = true;
                     _loc5_ = new Rectangle();
                     _window.getGlobalRectangle(_loc5_);
                     _loc4_ = new Point(_loc5_.x + _loc5_.width / 2,_loc5_.y + _loc5_.height);
                     widget.openBotSkillConfigurationView(UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.id,5,_loc4_);
               }
               if(param2.parent.name.indexOf(":link ") != -1)
               {
                  _loc8_ = param2.parent.name.substr(6,param2.parent.name.length - 6);
                  widget.component.context.createLinkEvent(_loc8_);
                  _loc3_ = true;
               }
               if(param2.parent.name.indexOf("nux_proceed_") != -1)
               {
                  _loc7_ = param2.parent.name.substr(12,param2.parent.name.length - 12);
                  widget.handler.container.connection.send(new CommandBotComposer(UnknownVarFromRentableBotMenuView_RentableBotInfoData_1.id,8,_loc7_));
                  _loc3_ = true;
               }
            }
            updateButtons();
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
      
      private function get widget() : AvatarInfoWidget
      {
         return UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 as AvatarInfoWidget;
      }
   }
}

