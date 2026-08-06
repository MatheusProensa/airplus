package com.sulake.habbo.avatar.view
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.AvatarEditorView;
   import com.sulake.habbo.avatar.HabboAvatarEditorManager;
   import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
   
   public class AvatarEditorNameChangeView
   {
      private static var NAME_SUGGESTION_BG_COLOR:uint = 13232628;
      
      private static var NAME_SUGGESTION_BG_COLOR_OVER:uint = 11129827;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromAvatarEditorNameChangeView_AvatarEditorView_1:AvatarEditorView;
      
      private var UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1:HabboAvatarEditorManager;
      
      private var UnknownVarFromAvatarEditorNameChangeView_AvatarEditorNameSuggestionListRenderer_1:AvatarEditorNameSuggestionListRenderer;
      
      private var _checkedName:String;
      
      private var _pendingName:String;
      
      private var UnknownVarFromAvatarEditorNameChangeView_Boolean_1:Boolean = false;
      
      public function AvatarEditorNameChangeView(param1:AvatarEditorView, param2:int, param3:int)
      {
         super();
         UnknownVarFromAvatarEditorNameChangeView_AvatarEditorView_1 = param1;
         UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1 = UnknownVarFromAvatarEditorNameChangeView_AvatarEditorView_1.editor.manager;
         _window = IFrameController(UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.windowManager.buildFromXML(XML(new HabboAvatarEditorCom.avatar_editor_name_change())));
         _window.x = param2;
         var _loc4_:int = int(UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.windowManager.getDesktop(1).width);
         if(_window.x + _window.width > _loc4_)
         {
            _window.x = _loc4_ - _window.width;
         }
         _window.y = param3;
         initControls();
      }
      
      private function initControls() : void
      {
         _window.procedure = windowEventHandler;
         var _loc1_:UnknownICoreWindowComponents4 = _window.findChildByName("select_name_button") as UnknownICoreWindowComponents4;
         if(_loc1_)
         {
            _loc1_.disable();
         }
      }
      
      public function focus() : void
      {
         _window.activate();
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
               _loc1_.caption = UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.localization.getLocalization("help.tutorial.name.wait_while_checking");
            }
         }
         UnknownVarFromAvatarEditorNameChangeView_Boolean_1 = true;
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:IWindowModel = null;
         var _loc4_:ITextFieldWindow = null;
         if(!UnknownVarFromAvatarEditorNameChangeView_Boolean_1)
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
         var _loc5_:* = param2.name;
         if("check_name_button" === _loc5_)
         {
            UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.handler.checkName(getName());
            nameCheckWaitBegin();
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
      
      public function set checkedName(param1:String) : void
      {
         _checkedName = param1;
         if(_pendingName == _checkedName)
         {
            return;
         }
         setNameAvailableView();
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
         UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.localization.registerParameter("help.tutorial.name.available","name",_checkedName);
         _loc2_.text = UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.localization.getLocalization("help.tutorial.name.available");
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
               UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.localization.registerParameter("help.tutorial.name.taken","name",param2);
               _loc5_.text = UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.localization.getLocalization("help.tutorial.name.taken");
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_5:
               UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.localization.registerParameter("help.tutorial.name.invalid","name",param2);
               _loc5_.text = UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.localization.getLocalization("help.tutorial.name.invalid");
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_2:
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_4:
               _loc5_.text = UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.localization.getLocalization("help.tutorial.name.long");
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_3:
               _loc5_.text = UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.localization.getLocalization("help.tutorial.name.short");
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_7:
               _loc5_.text = UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.localization.getLocalization("help.tutorial.name.change_not_allowed");
               break;
            case ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_8:
               _loc5_.text = UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.localization.getLocalization("help.tutorial.name.merge_hotel_down");
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
         UnknownVarFromAvatarEditorNameChangeView_AvatarEditorNameSuggestionListRenderer_1 = new AvatarEditorNameSuggestionListRenderer(UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1);
         var _loc7_:int = UnknownVarFromAvatarEditorNameChangeView_AvatarEditorNameSuggestionListRenderer_1.render(param3,_loc4_);
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
         UnknownVarFromAvatarEditorNameChangeView_Boolean_1 = false;
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
         _loc2_.text = UnknownVarFromAvatarEditorNameChangeView_HabboAvatarEditorManager_1.localization.getLocalization("help.tutorial.name.info");
         var _loc1_:IWindowController_1 = _window.findChildByName("suggestions") as IWindowController_1;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.visible = false;
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
   }
}

