package com.sulake.habbo.help.namechange
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.users.UserNameChangedMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.avatar.ChangeUserNameInRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.avatar.CheckUserNameMessageComposer;
   import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
   import com.sulake.habbo.communication.messages.parser.users.UserNameChangedMessageParser;
   import com.sulake.habbo.help.HabboHelp;
   import com.sulake.habbo.help.INameChangeUI;
   import com.sulake.habbo.help.enum.HabboHelpTutorialEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   
   public class NameChangeController implements INameChangeUI, IComponentInterfaceQueue
   {
      public static const NAME_CHANGE:String = "TUI_NAME_VIEW";
      
      private var _disposed:Boolean;
      
      private var _habboHelp:HabboHelp;
      
      private var UnknownVarFromNameChangeController_NameChangeView_1:NameChangeView;
      
      private var _ownUserName:String;
      
      private var _ownUserId:int;
      
      public function NameChangeController(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new UserNameChangedMessageEvent(onUserNameChange));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new CheckUserNameResultMessageEvent(onCheckUserNameResult));
         _habboHelp.communicationManager.addHabboConnectionMessageEvent(new ChangeUserNameResultMessageEvent(onChangeUserNameResult));
      }
      
      public function get help() : HabboHelp
      {
         return _habboHelp;
      }
      
      public function get assets() : IAssetLibraryCollection
      {
         return _habboHelp.assets;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _habboHelp.localization;
      }
      
      public function get myName() : String
      {
         return _ownUserName;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            disposeView();
            if(_habboHelp)
            {
               _habboHelp = null;
            }
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function showView() : void
      {
         if(UnknownVarFromNameChangeController_NameChangeView_1 == null || UnknownVarFromNameChangeController_NameChangeView_1.disposed)
         {
            UnknownVarFromNameChangeController_NameChangeView_1 = new NameChangeView(this);
         }
         UnknownVarFromNameChangeController_NameChangeView_1.showMainView();
         prepareForTutorial();
      }
      
      public function buildXmlWindow(param1:String, param2:uint = 1) : IWindowModel
      {
         if(_habboHelp.assets == null)
         {
            return null;
         }
         var _loc3_:XmlAsset = XmlAsset(_habboHelp.assets.getAssetByName(param1 + "_xml"));
         if(_loc3_ == null || _habboHelp.windowManager == null)
         {
            return null;
         }
         return _habboHelp.windowManager.buildFromXML(XML(_loc3_.content),param2);
      }
      
      private function disposeWindow(param1:WindowEvent = null) : void
      {
      }
      
      public function disposeView() : void
      {
         if(UnknownVarFromNameChangeController_NameChangeView_1 != null)
         {
            UnknownVarFromNameChangeController_NameChangeView_1.dispose();
            UnknownVarFromNameChangeController_NameChangeView_1 = null;
         }
         disposeWindow();
      }
      
      public function hideView() : void
      {
         if(UnknownVarFromNameChangeController_NameChangeView_1 != null)
         {
            UnknownVarFromNameChangeController_NameChangeView_1.dispose();
            UnknownVarFromNameChangeController_NameChangeView_1 = null;
         }
      }
      
      public function setRoomSessionStatus(param1:Boolean) : void
      {
         if(param1 == false)
         {
            disposeView();
         }
      }
      
      public function prepareForTutorial() : void
      {
         if(_habboHelp == null || _habboHelp.events == null)
         {
            return;
         }
         _habboHelp.events.dispatchEvent(new HabboHelpTutorialEvent("HHTPNUFWE_AVATAR_TUTORIAL_START"));
      }
      
      public function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:* = param1.type;
         if("WME_CLICK" === _loc3_)
         {
            if(param2.name == "header_button_close")
            {
               disposeView();
            }
         }
      }
      
      public function changeName(param1:String) : void
      {
         disposeWindow();
         _habboHelp.sendMessage(new ChangeUserNameInRoomMessageComposer(param1));
      }
      
      public function checkName(param1:String) : void
      {
         disposeWindow();
         _habboHelp.sendMessage(new CheckUserNameMessageComposer(param1));
      }
      
      public function onUserNameChanged(param1:String) : void
      {
         var name:String = param1;
         if(!_habboHelp || !_habboHelp.localization || !_habboHelp.windowManager)
         {
            return;
         }
         _habboHelp.localization.registerParameter("help.tutorial.name.changed","name",name);
         _habboHelp.windowManager.alert("${generic.notice}","${help.tutorial.name.changed}",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
      
      private function onChangeUserNameResult(param1:ChangeUserNameResultMessageEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:ChangeUserNameResultMessageParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.resultCode == ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_1)
         {
            onUserNameChanged(_loc2_.name);
            hideView();
         }
         else if(UnknownVarFromNameChangeController_NameChangeView_1)
         {
            UnknownVarFromNameChangeController_NameChangeView_1.setNameNotAvailableView(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
         }
      }
      
      private function onCheckUserNameResult(param1:CheckUserNameResultMessageEvent) : void
      {
         if(!param1 || !UnknownVarFromNameChangeController_NameChangeView_1)
         {
            return;
         }
         var _loc2_:CheckUserNameResultMessageParser = param1.getParser();
         if(_loc2_.resultCode == ChangeUserNameResultMessageEvent.UnknownVarFromChangeUserNameResultMessageEvent_Int_1)
         {
            UnknownVarFromNameChangeController_NameChangeView_1.checkedName = _loc2_.name;
         }
         else
         {
            UnknownVarFromNameChangeController_NameChangeView_1.setNameNotAvailableView(_loc2_.resultCode,_loc2_.name,_loc2_.nameSuggestions);
         }
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:UserObjectMessageParser = UserObjectEvent(param1).getParser();
         _ownUserId = _loc2_.id;
         _ownUserName = _loc2_.name;
      }
      
      private function onUserNameChange(param1:IMessageEvent) : void
      {
         var _loc2_:UserNameChangedMessageParser = UserNameChangedMessageEvent(param1).getParser();
         if(_ownUserId == _loc2_.webId)
         {
            _ownUserName = _loc2_.newName;
         }
      }
      
      public function get ownUserName() : String
      {
         return _ownUserName;
      }
      
      public function get ownUserId() : int
      {
         return _ownUserId;
      }
   }
}

