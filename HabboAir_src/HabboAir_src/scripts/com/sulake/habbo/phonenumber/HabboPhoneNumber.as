package com.sulake.habbo.phonenumber
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.gifts.PhoneCollectionStateMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.gifts.TryPhoneNumberResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.gifts.TryVerificationCodeResultMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.gifts.ResetPhoneNumberStateMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.gifts.SetPhoneNumberVerificationStatusMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.gifts.TryPhoneNumberMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.gifts.VerifyCodeMessageComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.utils.getTimer;
   
   public class HabboPhoneNumber extends Component
   {
      protected var _communicationManager:IHabboCommunicationManager;
      
      protected var _localizationManager:IHabboLocalizationManager;
      
      protected var _sessionDataManager:ISessionDataManager;
      
      protected var _toolbar:IHabboToolbar;
      
      protected var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromHabboPhoneNumber_IConnection_1:IConnection;
      
      private var UnknownVarFromHabboPhoneNumber_PhoneNumberCollectView_1:PhoneNumberCollectView;
      
      private var UnknownVarFromHabboPhoneNumber_PhoneNumberCollectMinimizedView_1:PhoneNumberCollectMinimizedView;
      
      private var UnknownVarFromHabboPhoneNumber_VerificationCodeInputView_1:VerificationCodeInputView;
      
      private var UnknownVarFromHabboPhoneNumber_VerificationCodeInputMinimizedView_1:VerificationCodeInputMinimizedView;
      
      private var _retryEnableTime:int;
      
      public function HabboPhoneNumber(param1:IComponent_2, param2:uint, param3:IAssetLibraryCollection)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         if(getBoolean("sms.identity.verification.enabled"))
         {
            UnknownVarFromHabboPhoneNumber_IConnection_1 = _communicationManager.connection;
            UnknownVarFromHabboPhoneNumber_IConnection_1.addMessageEvent(new PhoneCollectionStateMessageEvent(onStateMessage));
            UnknownVarFromHabboPhoneNumber_IConnection_1.addMessageEvent(new TryPhoneNumberResultMessageEvent(onPhoneNumberResultMessage));
            UnknownVarFromHabboPhoneNumber_IConnection_1.addMessageEvent(new TryVerificationCodeResultMessageEvent(onVerificationCodeResultMessage));
         }
      }
      
      public function sendTryPhoneNumber(param1:String, param2:String) : void
      {
         UnknownVarFromHabboPhoneNumber_IConnection_1.send(new TryPhoneNumberMessageComposer(param1,param2));
      }
      
      public function sendTryVerificationCode(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         param1 = param1.toUpperCase();
         UnknownVarFromHabboPhoneNumber_IConnection_1.send(new VerifyCodeMessageComposer(param1));
      }
      
      public function setNeverAgain() : void
      {
         UnknownVarFromHabboPhoneNumber_IConnection_1.send(new SetPhoneNumberVerificationStatusMessageComposer(2));
         destroyCollectView();
      }
      
      public function setCollectViewMinimized(param1:Boolean) : void
      {
         if(param1)
         {
            destroyCollectView();
            createCollectMinimizedView();
         }
         else
         {
            destroyCollectMinimizedView();
            createCollectView();
         }
      }
      
      public function setVerifyViewMinimized(param1:Boolean) : void
      {
         if(param1)
         {
            destroyVerifyView();
            createVerifyMinimizedView();
         }
         else
         {
            destroyVerifyMinimizedView();
            createVerifyView();
         }
      }
      
      public function requestPhoneNumberCollectionReset() : void
      {
         destroyVerifyView();
         UnknownVarFromHabboPhoneNumber_IConnection_1.send(new ResetPhoneNumberStateMessageComposer());
      }
      
      private function onPhoneNumberResultMessage(param1:TryPhoneNumberResultMessageEvent) : void
      {
         switch(param1.getParser().resultCode - 1)
         {
            case 0:
            case 2:
            case 8:
               destroyCollectView();
               _retryEnableTime = param1.getParser().millisToAllowProcessReset + getTimer();
               createVerifyView();
               break;
            case 1:
               destroyCollectView();
               break;
            case 3:
            case 4:
            case 5:
            case 9:
               if(!UnknownVarFromHabboPhoneNumber_PhoneNumberCollectMinimizedView_1 && !UnknownVarFromHabboPhoneNumber_PhoneNumberCollectView_1)
               {
                  createCollectView();
               }
               else if(UnknownVarFromHabboPhoneNumber_PhoneNumberCollectMinimizedView_1)
               {
                  setCollectViewMinimized(false);
               }
               _windowManager.alert("${generic.alert.title}","${phone.number.collect.error." + param1.getParser().resultCode + "}",0,null);
               UnknownVarFromHabboPhoneNumber_PhoneNumberCollectView_1.handleSubmitFailure(param1.getParser().resultCode);
         }
      }
      
      private function onVerificationCodeResultMessage(param1:TryVerificationCodeResultMessageEvent) : void
      {
         switch(param1.getParser().resultCode - 2)
         {
            case 0:
            case 1:
               destroyVerifyView();
               break;
            case 2:
               if(!UnknownVarFromHabboPhoneNumber_VerificationCodeInputMinimizedView_1 && !UnknownVarFromHabboPhoneNumber_VerificationCodeInputView_1)
               {
                  _retryEnableTime = getTimer() + param1.getParser().millisecondsToAllowProcessReset;
                  createVerifyView();
               }
               else if(UnknownVarFromHabboPhoneNumber_VerificationCodeInputMinimizedView_1)
               {
                  setVerifyViewMinimized(false);
               }
               UnknownVarFromHabboPhoneNumber_VerificationCodeInputView_1.handleSubmitFailure(param1.getParser().resultCode);
         }
      }
      
      private function onStateMessage(param1:PhoneCollectionStateMessageEvent) : void
      {
         var _loc2_:int = param1.getParser().collectionStatusCode;
         var _loc3_:int = param1.getParser().phoneStatusCode;
         context.configuration.setProperty("phone.collection.status",_loc2_.toString());
         context.configuration.setProperty("phone.verification.status",_loc3_.toString());
         if(_loc2_ == 2)
         {
            return;
         }
         if(_loc2_ == 3 && (_loc3_ == 9 || _loc3_ == 1))
         {
            destroyCollectView();
            if(_loc2_ == 1)
            {
               createVerifyMinimizedView();
            }
            else
            {
               _retryEnableTime = param1.getParser().millisecondsToAllowProcessReset + getTimer();
               createVerifyView();
            }
            return;
         }
         switch(_loc3_)
         {
            case 0:
            case 9:
               createCollectView();
               break;
            case 2:
            case 3:
               destroyCollectView();
               destroyVerifyView();
               break;
            case 4:
            case 5:
            case 6:
               Logger.log("INVALID STATE!! Phone number / verify errors should not be handled here!");
         }
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get retryEnableTime() : int
      {
         return _retryEnableTime;
      }
      
      private function createCollectView() : void
      {
         destroyCollectView();
         var _loc2_:String = context.configuration.getProperty("phone.number.preferred.countries");
         var _loc1_:Array = _loc2_.split(",");
         UnknownVarFromHabboPhoneNumber_PhoneNumberCollectView_1 = new PhoneNumberCollectView(this,_loc1_);
      }
      
      private function createVerifyView() : void
      {
         destroyVerifyView();
         UnknownVarFromHabboPhoneNumber_VerificationCodeInputView_1 = new VerificationCodeInputView(this);
      }
      
      private function createCollectMinimizedView() : void
      {
         destroyCollectMinimizedView();
         UnknownVarFromHabboPhoneNumber_PhoneNumberCollectMinimizedView_1 = new PhoneNumberCollectMinimizedView(this);
         _toolbar.extensionView.attachExtension("phone_number",UnknownVarFromHabboPhoneNumber_PhoneNumberCollectMinimizedView_1.window,12);
      }
      
      private function createVerifyMinimizedView() : void
      {
         destroyVerifyMinimizedView();
         UnknownVarFromHabboPhoneNumber_VerificationCodeInputMinimizedView_1 = new VerificationCodeInputMinimizedView(this);
         _toolbar.extensionView.attachExtension("verification_code",UnknownVarFromHabboPhoneNumber_VerificationCodeInputMinimizedView_1.window,12);
      }
      
      private function destroyCollectView() : void
      {
         if(UnknownVarFromHabboPhoneNumber_PhoneNumberCollectView_1)
         {
            UnknownVarFromHabboPhoneNumber_PhoneNumberCollectView_1.dispose();
            UnknownVarFromHabboPhoneNumber_PhoneNumberCollectView_1 = null;
         }
      }
      
      private function destroyVerifyView() : void
      {
         if(UnknownVarFromHabboPhoneNumber_VerificationCodeInputView_1)
         {
            UnknownVarFromHabboPhoneNumber_VerificationCodeInputView_1.dispose();
            UnknownVarFromHabboPhoneNumber_VerificationCodeInputView_1 = null;
         }
      }
      
      private function destroyCollectMinimizedView() : void
      {
         _toolbar.extensionView.detachExtension("phone_number");
         if(UnknownVarFromHabboPhoneNumber_PhoneNumberCollectMinimizedView_1)
         {
            UnknownVarFromHabboPhoneNumber_PhoneNumberCollectMinimizedView_1.dispose();
            UnknownVarFromHabboPhoneNumber_PhoneNumberCollectMinimizedView_1 = null;
         }
      }
      
      private function destroyVerifyMinimizedView() : void
      {
         _toolbar.extensionView.detachExtension("verification_code");
         if(UnknownVarFromHabboPhoneNumber_VerificationCodeInputMinimizedView_1)
         {
            UnknownVarFromHabboPhoneNumber_VerificationCodeInputMinimizedView_1.dispose();
            UnknownVarFromHabboPhoneNumber_VerificationCodeInputMinimizedView_1 = null;
         }
      }
   }
}

