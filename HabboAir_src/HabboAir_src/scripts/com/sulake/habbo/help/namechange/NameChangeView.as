package com.sulake.habbo.help.namechange
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
   import com.sulake.habbo.help.INameChangeUI;
   import flash.external.ExternalInterface;
   
   public class NameChangeView implements IComponentInterfaceQueue
   {
      private static const NAME_UPDATE_FUNCTION:String = "FlashExternalInterface.updateName";
      
      private static var NAME_SUGGESTION_BG_COLOR:uint = 13232628;
      
      private static var NAME_SUGGESTION_BG_COLOR_OVER:uint = 11129827;
      
      private var UnknownVarFromNameChangeView_INameChangeUI_1:INameChangeUI;
      
      private var _window:IFrameController;
      
      private var _checkedName:String;
      
      private var _pendingName:String;
      
      private var UnknownVarFromNameChangeView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromNameChangeView_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromNameChangeView_IWindowController_1_3:IWindowController_1;
      
      private var UnknownVarFromNameChangeView_IWindowController_1_4:IWindowController_1;
      
      private var UnknownVarFromNameChangeView_Boolean_1:Boolean = false;
      
      private var UnknownVarFromNameChangeView_NameSuggestionListRenderer_1:NameSuggestionListRenderer;
      
      private var _disposed:Boolean;
      
      public function NameChangeView(param1:INameChangeUI)
      {
         super();
         UnknownVarFromNameChangeView_INameChangeUI_1 = param1;
      }
      
      public function get id() : String
      {
         return "TUI_NAME_VIEW";
      }
      
      public function set checkedName(param1:String) : void
      {
         _checkedName = param1;
         if(_pendingName == _checkedName)
         {
            showConfirmationView();
            return;
         }
         setNameAvailableView();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            disposeWindow();
            if(UnknownVarFromNameChangeView_NameSuggestionListRenderer_1 != null)
            {
               UnknownVarFromNameChangeView_NameSuggestionListRenderer_1.dispose();
               UnknownVarFromNameChangeView_NameSuggestionListRenderer_1 = null;
            }
            _disposed = true;
         }
      }
      
      private function disposeWindow() : void
      {
         UnknownVarFromNameChangeView_IWindowController_1_1 = null;
         UnknownVarFromNameChangeView_IWindowController_1_2 = null;
         UnknownVarFromNameChangeView_IWindowController_1_3 = null;
         UnknownVarFromNameChangeView_IWindowController_1_4 = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function showView(param1:IWindowController_1) : void
      {
         UnknownVarFromNameChangeView_Boolean_1 = false;
         if(UnknownVarFromNameChangeView_IWindowController_1_4)
         {
            UnknownVarFromNameChangeView_IWindowController_1_4.visible = false;
         }
         UnknownVarFromNameChangeView_IWindowController_1_4 = param1;
         UnknownVarFromNameChangeView_IWindowController_1_4.visible = true;
         if(_window)
         {
            _window.content.width = UnknownVarFromNameChangeView_IWindowController_1_4.width;
            _window.content.height = UnknownVarFromNameChangeView_IWindowController_1_4.height;
         }
      }
      
      public function showMainView() : void
      {
         if(!_window)
         {
            _window = UnknownVarFromNameChangeView_INameChangeUI_1.buildXmlWindow("welcome_name_change") as IFrameController;
            _window.center();
            _window.procedure = windowEventHandler;
            UnknownVarFromNameChangeView_IWindowController_1_1 = _window.content.getChildAt(0) as IWindowController_1;
         }
         UnknownVarFromNameChangeView_INameChangeUI_1.localization.registerParameter("tutorial.name_change.current","name",UnknownVarFromNameChangeView_INameChangeUI_1.myName);
         _window.caption = UnknownVarFromNameChangeView_INameChangeUI_1.localization.getLocalization("tutorial.name_change.title.main");
         showView(UnknownVarFromNameChangeView_IWindowController_1_1);
      }
      
      private function showSelectionView() : void
      {
         if(!UnknownVarFromNameChangeView_IWindowController_1_2)
         {
            UnknownVarFromNameChangeView_IWindowController_1_2 = UnknownVarFromNameChangeView_INameChangeUI_1.buildXmlWindow("welcome_name_selection") as IWindowController_1;
            if(!UnknownVarFromNameChangeView_IWindowController_1_2)
            {
               return;
            }
            _window.content.addChild(UnknownVarFromNameChangeView_IWindowController_1_2);
         }
         _window.caption = UnknownVarFromNameChangeView_INameChangeUI_1.localization.getLocalization("tutorial.name_change.title.select");
         var _loc1_:UnknownICoreWindowComponents4 = _window.findChildByName("select_name_button") as UnknownICoreWindowComponents4;
         if(_loc1_)
         {
            _loc1_.disable();
         }
         setNormalView();
         showView(UnknownVarFromNameChangeView_IWindowController_1_2);
      }
      
      private function showConfirmationView() : void
      {
         if(!UnknownVarFromNameChangeView_IWindowController_1_3)
         {
            UnknownVarFromNameChangeView_IWindowController_1_3 = UnknownVarFromNameChangeView_INameChangeUI_1.buildXmlWindow("welcome_name_confirmation") as IWindowController_1;
            if(!UnknownVarFromNameChangeView_IWindowController_1_3)
            {
               return;
            }
            _window.content.addChild(UnknownVarFromNameChangeView_IWindowController_1_3);
         }
         _window.caption = UnknownVarFromNameChangeView_INameChangeUI_1.localization.getLocalization("tutorial.name_change.title.confirm");
         var _loc1_:ITextWindow = UnknownVarFromNameChangeView_IWindowController_1_3.findChildByName("final_name") as ITextWindow;
         if(_loc1_)
         {
            _loc1_.text = _checkedName;
         }
         showView(UnknownVarFromNameChangeView_IWindowController_1_3);
         if(ExternalInterface.available)
         {
            ExternalInterface.call("FlashExternalInterface.updateName",_checkedName);
         }
      }
      
      public function get view() : IWindowController_1
      {
         return _window;
      }
      
      public function setNormalView() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:ITextWindow = _window.findChildByName("info_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = UnknownVarFromNameChangeView_INameChangeUI_1.localization.getLocalization("help.tutorial.name.info");
         var _loc1_:IWindowController_1 = _window.findChildByName("suggestions") as IWindowController_1;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = false;
      }
      
      public function setNameAvailableView() : void
      {
         if(_window == null)
         {
            return;
         }
         nameCheckWaitEnd(true);
         var _loc2_:ITextWindow = _window.findChildByName("info_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         UnknownVarFromNameChangeView_INameChangeUI_1.localization.registerParameter("help.tutorial.name.available","name",_checkedName);
         _loc2_.text = UnknownVarFromNameChangeView_INameChangeUI_1.localization.getLocalization("help.tutorial.name.available");
         var _loc3_:ITextFieldWindow = _window.findChildByName("input") as ITextFieldWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = _checkedName;
         var _loc1_:IWindowController_1 = _window.findChildByName("suggestions") as IWindowController_1;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = false;
      }
      
      public function setNameNotAvailableView(param1:int, param2:String, param3:Array) : void
      {
         var _loc8_:int = 0;
         var _loc6_:IWindowModel = null;
         nameCheckWaitEnd(false);
         if(UnknownVarFromNameChangeView_IWindowController_1_4 != UnknownVarFromNameChangeView_IWindowController_1_2)
         {
            showSelectionView();
         }
         _pendingName = null;
         _checkedName = null;
         if(_window == null)
         {
            return;
         }
         var _loc5_:ITextWindow = _window.findChildByName("info_text") as ITextWindow;
         if(_loc5_ == null)
         {
            return;
         }
         switch(param1)
         {
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_6:
               UnknownVarFromNameChangeView_INameChangeUI_1.localization.registerParameter("help.tutorial.name.taken","name",param2);
               _loc5_.text = UnknownVarFromNameChangeView_INameChangeUI_1.localization.getLocalization("help.tutorial.name.taken");
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_5:
               UnknownVarFromNameChangeView_INameChangeUI_1.localization.registerParameter("help.tutorial.name.invalid","name",param2);
               _loc5_.text = UnknownVarFromNameChangeView_INameChangeUI_1.localization.getLocalization("help.tutorial.name.invalid");
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_2:
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_4:
               _loc5_.text = UnknownVarFromNameChangeView_INameChangeUI_1.localization.getLocalization("help.tutorial.name.long");
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_3:
               _loc5_.text = UnknownVarFromNameChangeView_INameChangeUI_1.localization.getLocalization("help.tutorial.name.short");
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_7:
               _loc5_.text = UnknownVarFromNameChangeView_INameChangeUI_1.localization.getLocalization("help.tutorial.name.change_not_allowed");
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_8:
               _loc5_.text = UnknownVarFromNameChangeView_INameChangeUI_1.localization.getLocalization("help.tutorial.name.merge_hotel_down");
         }
         var _loc4_:IWindowController_1 = _window.findChildByName("suggestions") as IWindowController_1;
         if(_loc4_ == null)
         {
            return;
         }
         if(param1 == ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_8 || param1 == ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_7)
         {
            _loc4_.visible = false;
            return;
         }
         _loc4_.visible = true;
         UnknownVarFromNameChangeView_NameSuggestionListRenderer_1 = new NameSuggestionListRenderer(UnknownVarFromNameChangeView_INameChangeUI_1);
         var _loc7_:int = UnknownVarFromNameChangeView_NameSuggestionListRenderer_1.render(param3,_loc4_);
         _loc8_ = 0;
         while(_loc8_ < _loc4_.numChildren)
         {
            _loc6_ = _loc4_.getChildAt(_loc8_);
            _loc6_.color = NAME_SUGGESTION_BG_COLOR;
            _loc6_.addEventListener("WME_CLICK",nameSelected);
            _loc6_.addEventListener("WME_OVER",nameOver);
            _loc6_.addEventListener("WME_OUT",nameOut);
            _loc8_++;
         }
      }
      
      private function nameSelected(param1:WindowMouseEvent) : void
      {
         nameCheckWaitEnd(true);
         var _loc4_:ITextWindow = param1.target as ITextWindow;
         if(!_loc4_)
         {
            return;
         }
         var _loc3_:String = _loc4_.text;
         setNormalView();
         var _loc2_:ITextFieldWindow = _window.findChildByName("input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = _loc3_;
      }
      
      private function nameOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = param1.target as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.color = NAME_SUGGESTION_BG_COLOR_OVER;
         }
      }
      
      private function nameOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = param1.target as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.color = NAME_SUGGESTION_BG_COLOR;
         }
      }
      
      public function nameCheckWaitBegin() : void
      {
         var _loc1_:IWindowModel = null;
         if(_window && !_window.disposed)
         {
            _loc1_ = _window.findChildByName("select_name_button");
            if(_loc1_)
            {
               _loc1_.disable();
            }
            _loc1_ = _window.findChildByName("check_name_button");
            if(_loc1_)
            {
               _loc1_.disable();
            }
            _loc1_ = _window.findChildByName("input");
            if(_loc1_)
            {
               _loc1_.disable();
            }
            _loc1_ = _window.findChildByName("info_text");
            if(_loc1_)
            {
               _loc1_.caption = UnknownVarFromNameChangeView_INameChangeUI_1.localization.getLocalization("help.tutorial.name.wait_while_checking");
            }
         }
         UnknownVarFromNameChangeView_Boolean_1 = true;
      }
      
      public function nameCheckWaitEnd(param1:Boolean) : void
      {
         var _loc2_:IWindowModel = null;
         if(_window && !_window.disposed)
         {
            if(param1)
            {
               _loc2_ = _window.findChildByName("select_name_button");
               if(_loc2_)
               {
                  _loc2_.enable();
               }
            }
            _loc2_ = _window.findChildByName("check_name_button");
            if(_loc2_)
            {
               _loc2_.enable();
            }
            _loc2_ = _window.findChildByName("input");
            if(_loc2_)
            {
               _loc2_.enable();
            }
         }
         UnknownVarFromNameChangeView_Boolean_1 = false;
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:IWindowModel = null;
         var _loc4_:ITextFieldWindow = null;
         var _loc5_:String = null;
         if(!UnknownVarFromNameChangeView_Boolean_1)
         {
            if(param1.type == "WE_CHANGE")
            {
               if(param2.name == "input")
               {
                  _loc3_ = _window.findChildByName("select_name_button");
                  _loc4_ = param2 as ITextFieldWindow;
                  if(_loc3_ && _loc4_)
                  {
                     if(_loc4_.text.length > 2)
                     {
                        _loc3_.enable();
                     }
                     else
                     {
                        _loc3_.disable();
                     }
                  }
               }
            }
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "change_name_button":
               showSelectionView();
               break;
            case "keep_name_button":
               _checkedName = UnknownVarFromNameChangeView_INameChangeUI_1.myName;
               showConfirmationView();
               break;
            case "check_name_button":
               UnknownVarFromNameChangeView_INameChangeUI_1.checkName(getName());
               nameCheckWaitBegin();
               break;
            case "select_name_button":
               _loc5_ = getName();
               if(_loc5_.length < 1)
               {
                  return;
               }
               if(_checkedName != _loc5_)
               {
                  _pendingName = _loc5_;
                  UnknownVarFromNameChangeView_INameChangeUI_1.checkName(_loc5_);
                  nameCheckWaitBegin();
               }
               else
               {
                  showConfirmationView();
               }
               break;
            case "cancel_selection_button":
               UnknownVarFromNameChangeView_INameChangeUI_1.hideView();
               break;
            case "confirm_name_button":
               UnknownVarFromNameChangeView_INameChangeUI_1.changeName(_checkedName);
               break;
            case "cancel_confirmation_button":
               UnknownVarFromNameChangeView_INameChangeUI_1.hideView();
               break;
            case "header_button_close":
               UnknownVarFromNameChangeView_INameChangeUI_1.hideView();
         }
      }
      
      private function getName() : String
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
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

