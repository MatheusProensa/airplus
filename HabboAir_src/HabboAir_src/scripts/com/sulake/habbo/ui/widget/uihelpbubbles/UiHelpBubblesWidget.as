package com.sulake.habbo.ui.widget.uihelpbubbles
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendbar.view.IHabboFriendBarView;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetScriptProceedMessage;
   import com.sulake.habbo.ui.widget.roomtools.RoomToolsWidget;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class UiHelpBubblesWidget extends RoomWidgetBase implements ILinkEventTracker
   {
      private var UnknownVarFromUiHelpBubblesWidget_Component_1:Component;
      
      private var _bubbles:Map;
      
      private var _toolBar:IHabboToolbar;
      
      private var _friendBar:IHabboFriendBarView;
      
      private var _roomTools:RoomToolsWidget;
      
      private var _chatInput:RoomChatInputWidget;
      
      private var UnknownVarFromUiHelpBubblesWidget_Array_1:Array;
      
      private var UnknownVarFromUiHelpBubblesWidget_Int_1:int = 0;
      
      private var _localization:IHabboLocalizationManager;
      
      public function UiHelpBubblesWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:IHabboFriendBarView, param6:IHabboToolbar, param7:IRoomDesktop, param8:Component)
      {
         super(param1,param2,param3,param4);
         UnknownVarFromUiHelpBubblesWidget_Component_1 = param8;
         _friendBar = param5;
         _toolBar = param6;
         _bubbles = new Map();
         _localization = param4;
         UnknownVarFromUiHelpBubblesWidget_Array_1 = [];
         if(param7)
         {
            _roomTools = param7.getWidget("RWE_ROOM_TOOLS") as RoomToolsWidget;
            _chatInput = param7.getWidget("RWE_CHAT_INPUT_WIDGET") as RoomChatInputWidget;
         }
         (param2 as Component).context.addLinkEventTracker(this);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_bubbles)
         {
            for each(var _loc1_ in _bubbles)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            _bubbles.dispose();
            _bubbles = null;
            UnknownVarFromUiHelpBubblesWidget_Array_1 = null;
         }
         super.dispose();
      }
      
      private function checkElementPosition(param1:UiHelpBubble, param2:Boolean = false) : Rectangle
      {
         var _loc9_:Rectangle = null;
         var _loc14_:IWindowController_1 = null;
         var _loc5_:IWindowModel = null;
         var _loc8_:Array = null;
         var _loc3_:IWindowController_1 = null;
         var _loc10_:ITextFieldWindow = null;
         var _loc13_:Rectangle = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(!param1 || !param1.getWindow())
         {
            return null;
         }
         var _loc11_:String = param1.getName();
         if(_loc11_ == "" || !_loc11_)
         {
            return null;
         }
         var _loc15_:int = int(param1.getWindow().height);
         var _loc12_:int = int(param1.getWindow().width);
         var _loc16_:String = "down";
         var _loc17_:* = -1;
         if(toolBar)
         {
            _loc5_ = toolBar.getIcon(_loc11_);
            if(_loc5_)
            {
               _loc9_ = new Rectangle();
               _loc5_.getGlobalRectangle(_loc9_);
               param1.setCallback(_loc5_);
            }
         }
         if(friendBar)
         {
            if(!_loc9_)
            {
               _loc14_ = friendBar.getIconLocation(_loc11_);
               if(_loc14_)
               {
                  _loc9_ = new Rectangle();
                  _loc14_.getGlobalRectangle(_loc9_);
                  param1.setCallback(_loc14_ as IWindowModel);
               }
            }
         }
         if(!_loc9_)
         {
            if(roomTools)
            {
               _loc5_ = roomTools.getIconLocation(_loc11_);
               if(_loc5_)
               {
                  _loc9_ = new Rectangle();
                  _loc5_.getGlobalRectangle(_loc9_);
                  param1.setCallback(_loc5_);
               }
            }
         }
         if(!_loc9_)
         {
            if(chatInput && _loc11_ == "chat_input")
            {
               _loc8_ = chatInput.getChatInputElements();
               if(_loc8_.length > 1)
               {
                  _loc3_ = _loc8_[0] as IWindowController_1;
                  _loc10_ = _loc8_[1] as ITextFieldWindow;
               }
               _loc9_ = _loc3_.rectangle;
               if(_loc9_)
               {
                  if(param2 && _loc9_)
                  {
                     return _loc9_;
                  }
                  _loc9_.y -= _loc15_ - 40;
                  _loc9_.x += _loc9_.width / 2 - 10;
                  param1.setChatFieldCallback(_loc10_);
                  param1.setArrowPos(_loc16_,_loc17_);
                  return _loc9_;
               }
            }
         }
         if(_loc9_)
         {
            if(param2)
            {
               return _loc9_;
            }
            _loc13_ = _loc9_.clone();
            _loc4_ = 15;
            _loc6_ = int(param1.getWindow().desktop.width);
            if(_loc9_.y - (_loc15_ + _loc4_) < 50)
            {
               _loc4_ = 0;
            }
            _loc16_ = "down";
            _loc17_ = 0;
            _loc9_.x += _loc9_.width / 2;
            _loc9_.y -= _loc15_ + _loc4_;
            _loc7_ = _loc9_.right - _loc13_.right;
            if(_loc7_ >= _loc12_ / 2)
            {
               _loc7_ = _loc12_ / 2 - 25;
            }
            if(_loc9_.y < _loc15_)
            {
               _loc9_.y += _loc9_.height + _loc15_ + 10;
               _loc16_ = "up";
               if(_loc7_ <= 30)
               {
                  _loc7_ /= 3;
               }
               _loc17_ = _loc7_;
               param1.setArrowPos(_loc16_,_loc17_);
            }
            if(_loc9_.x < _loc12_ / 2)
            {
               _loc9_.x = 10;
               _loc17_ -= _loc12_ / 2 - 30;
               param1.setArrowPos(_loc16_,_loc17_);
               return _loc9_;
            }
            if(_loc9_.x + _loc12_ / 2 > _loc6_)
            {
               _loc9_.x = _loc6_ - _loc12_ / 2;
               _loc17_ = _loc12_ / 4;
               param1.setArrowPos(_loc16_,_loc17_);
               return _loc9_;
            }
            param1.setArrowPos(_loc16_,_loc17_);
         }
         return _loc9_;
      }
      
      public function addNextBubble() : void
      {
         var _loc5_:Point = null;
         if(!UnknownVarFromUiHelpBubblesWidget_Array_1 || UnknownVarFromUiHelpBubblesWidget_Array_1.length == 0 || UnknownVarFromUiHelpBubblesWidget_Array_1.length < UnknownVarFromUiHelpBubblesWidget_Int_1 + 1)
         {
            return;
         }
         var _loc3_:HelpBubbleItem = UnknownVarFromUiHelpBubblesWidget_Array_1[UnknownVarFromUiHelpBubblesWidget_Int_1] as HelpBubbleItem;
         var _loc2_:* = UnknownVarFromUiHelpBubblesWidget_Array_1.length > UnknownVarFromUiHelpBubblesWidget_Int_1 + 1;
         var _loc6_:String = _loc3_.name;
         var _loc4_:UiHelpBubble = new UiHelpBubble(this,_loc3_,_loc2_);
         if(_bubbles.hasKey(_loc6_))
         {
            removeHelpBubble(_loc6_);
         }
         var _loc1_:Rectangle = checkElementPosition(_loc4_);
         UnknownVarFromUiHelpBubblesWidget_Int_1++;
         if(_loc1_)
         {
            _loc5_ = new Point(_loc1_.x,_loc1_.y);
         }
         if(_loc5_)
         {
            _loc4_.setPosition(_loc5_);
            _loc4_.getWindow().desktop.addEventListener("WE_RESIZED",onDesktopResized);
            _loc4_.setModal(checkElementPosition(_loc4_,true));
            addHelpBubble(_loc6_,_loc4_);
         }
         else
         {
            _loc4_.dispose();
            addNextBubble();
         }
      }
      
      private function addHelpBubble(param1:String, param2:UiHelpBubble) : void
      {
         if(!_bubbles || !param2)
         {
            return;
         }
         _bubbles.add(param1,param2);
      }
      
      public function removeHelpBubble(param1:String) : void
      {
         if(!_bubbles)
         {
            return;
         }
         var _loc2_:UiHelpBubble = _bubbles.getValue(param1) as UiHelpBubble;
         if(!_loc2_)
         {
            return;
         }
         _bubbles.remove(param1);
         _loc2_.dispose();
         addNextBubble();
      }
      
      private function onDesktopResized(param1:WindowEvent = null) : void
      {
         var _loc2_:Rectangle = null;
         var _loc4_:Point = null;
         for each(var _loc3_ in _bubbles)
         {
            _loc2_ = checkElementPosition(_loc3_);
            if(_loc2_)
            {
               _loc4_ = new Point(_loc2_.x,_loc2_.y);
               _loc3_.setPosition(_loc4_);
               _loc3_.setModal(checkElementPosition(_loc3_,true));
            }
         }
      }
      
      public function sendScriptProceedMessage() : void
      {
         var _loc1_:RoomWidgetMessage = new RoomWidgetScriptProceedMessage("RWPM_ANSWER");
         if(messageListener)
         {
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      public function get linkPattern() : String
      {
         return "helpBubble/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc8_:int = 0;
         var _loc3_:HelpBubbleItem = null;
         var _loc7_:int = 0;
         var _loc6_:String = null;
         var _loc4_:* = null;
         if(!_bubbles)
         {
            _bubbles = new Map();
         }
         if(!UnknownVarFromUiHelpBubblesWidget_Array_1)
         {
            UnknownVarFromUiHelpBubblesWidget_Array_1 = [];
         }
         var _loc2_:Array = param1.split("/");
         var _loc5_:int = int(_loc2_.length);
         if(_loc5_ < 3)
         {
            return;
         }
         if(_loc2_[1] == "add")
         {
            _loc8_ = 0;
            _loc7_ = 2;
            while(_loc7_ < _loc5_)
            {
               _loc8_++;
               if(_loc8_ == 1)
               {
                  _loc3_ = new HelpBubbleItem();
                  _loc6_ = _loc2_[_loc7_];
                  _loc4_ = UiHelpBubbleIconEnum[_loc6_];
                  if(!_loc4_)
                  {
                     _loc4_ = _loc6_;
                  }
                  _loc3_.name = _loc4_;
                  _loc3_.modal = true;
               }
               if(_loc8_ == 2)
               {
                  _loc3_.text = _localization.getLocalization(_loc2_[_loc7_],_loc2_[_loc7_]);
                  _loc8_ = 0;
                  UnknownVarFromUiHelpBubblesWidget_Array_1.push(_loc3_);
               }
               _loc7_++;
            }
            addNextBubble();
         }
         else if(_loc2_[1] == "remove")
         {
            removeHelpBubble(_loc2_[2]);
         }
      }
      
      public function get toolBar() : IHabboToolbar
      {
         return _toolBar;
      }
      
      public function get friendBar() : IHabboFriendBarView
      {
         return _friendBar;
      }
      
      public function get roomTools() : RoomToolsWidget
      {
         return _roomTools;
      }
      
      public function get chatInput() : RoomChatInputWidget
      {
         return _chatInput;
      }
   }
}

