package com.sulake.habbo.communication.demo
{
   import com.hurlant.crypto.rsa.RSAKey;
   import com.hurlant.math.BigInteger;
   import com.sulake.core.Core;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.encryption.CryptoTools;
   import com.sulake.core.communication.encryption.IEncryption;
   import com.sulake.core.communication.handshake.UnknownICoreCommunicationHandshake1;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.login.AvatarData;
   import com.sulake.habbo.communication.messages.incoming.availability.LoginFailedHotelClosedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.MaintenanceStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.error.ErrorReportEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.CompleteDiffieHandshakeEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.DisconnectReasonEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.GenericErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.IdentityAccountsEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.InitDiffieHandshakeEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.PingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UniqueMachineIDEvent;
   import com.sulake.habbo.communication.messages.outgoing.handshake.ClientHelloMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.handshake.CompleteDiffieHandshakeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.handshake.InfoRetrieveMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.handshake.InitDiffieHandshakeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.handshake.PongMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.GetFurnitureAliasesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.parser.availability.LoginFailedHotelClosedMessageParser;
   import com.sulake.habbo.communication.messages.parser.availability.MaintenanceStatusMessageParser;
   import com.sulake.habbo.communication.messages.parser.error.ErrorReportMessageParser;
   import com.sulake.habbo.communication.messages.parser.handshake.GenericErrorParser;
   import com.sulake.habbo.utils.CommunicationUtils;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class IncomingMessages
   {
      private var UnknownVarFromIncomingMessages_HabboCommunicationDemo_1:HabboCommunicationDemo;
      
      private var _communication:IHabboCommunicationManager;
      
      private var UnknownVarFromIncomingMessages_UnknownICoreCommunicationHandshake1_1:UnknownICoreCommunicationHandshake1;
      
      private var _privateKey:String;
      
      private var _handshakeInProgress:Boolean;
      
      private var _logoutInProgress:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent> = new Vector.<IMessageEvent>(0);
      
      private var _rsa:RSAKey;
      
      public function IncomingMessages(param1:HabboCommunicationDemo, param2:IHabboCommunicationManager)
      {
         super();
         UnknownVarFromIncomingMessages_HabboCommunicationDemo_1 = param1;
         _communication = param2;
         var _loc3_:IConnection = _communication.connection;
         if(_loc3_ == null)
         {
            throw new Error("Connection is required to initialize!");
         }
         _loc3_.addEventListener("connect",onConnectionEstablished);
         _loc3_.addEventListener("close",onConnectionDisconnected);
         addHabboConnectionMessageEvent(new DisconnectReasonEvent(onDisconnectReason));
         addHabboConnectionMessageEvent(new CompleteDiffieHandshakeEvent(onCompleteDiffieHandshake));
         addHabboConnectionMessageEvent(new PingMessageEvent(onPing));
         addHabboConnectionMessageEvent(new UniqueMachineIDEvent(onUniqueMachineId));
         addHabboConnectionMessageEvent(new LoginFailedHotelClosedMessageEvent(onLoginFailedHotelClosed));
         addHabboConnectionMessageEvent(new GenericErrorEvent(onGenericError));
         addHabboConnectionMessageEvent(new InitDiffieHandshakeEvent(onInitDiffieHandshake));
         addHabboConnectionMessageEvent(new IdentityAccountsEvent(onIdentityAccounts));
         addHabboConnectionMessageEvent(new ErrorReportEvent(onErrorReport));
         addHabboConnectionMessageEvent(new MaintenanceStatusMessageEvent(onMaintenance));
         addHabboConnectionMessageEvent(new AuthenticationOKMessageEvent(onAuthenticationOK));
         UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.context.events.addEventListener("unload",unloading);
      }
      
      private static function setReasonProperty(param1:String, param2:String) : String
      {
         if(param1.indexOf("%reason%") != -1)
         {
            return param1.replace("%reason%",param2);
         }
         return param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:IConnection = null;
         if(_communication)
         {
            _loc1_ = _communication.connection;
            if(_loc1_ != null)
            {
               _loc1_.removeEventListener("connect",onConnectionEstablished);
               _loc1_.removeEventListener("close",onConnectionDisconnected);
            }
            for each(var _loc2_ in _messageEvents)
            {
               _communication.removeHabboConnectionMessageEvent(_loc2_);
            }
            _messageEvents = new Vector.<IMessageEvent>(0);
         }
         UnknownVarFromIncomingMessages_HabboCommunicationDemo_1 = null;
         _communication = null;
         UnknownVarFromIncomingMessages_UnknownICoreCommunicationHandshake1_1 = null;
      }
      
      private function addHabboConnectionMessageEvent(param1:IMessageEvent) : void
      {
         _communication.addHabboConnectionMessageEvent(param1);
         _messageEvents.push(param1);
      }
      
      private function unloading(param1:Event) : void
      {
         _logoutInProgress = true;
      }
      
      private function onInitDiffieHandshake(param1:IMessageEvent) : void
      {
         var _loc9_:String = null;
         var _loc16_:IConnection = param1.connection;
         var _loc2_:InitDiffieHandshakeEvent = param1 as InitDiffieHandshakeEvent;
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:ByteArray = new ByteArray();
         _loc3_.writeBytes(CryptoTools.hexStringToByteArray(_loc2_.encryptedPrime));
         _loc4_.writeBytes(CryptoTools.hexStringToByteArray(_loc2_.encryptedGenerator));
         var _loc5_:ByteArray = new ByteArray();
         var _loc8_:ByteArray = new ByteArray();
         _rsa = RSAKey.parsePublicKey(§_a_-_---§.§_a_--_--§(-1820302793),"10001");
         _rsa.verify(_loc3_,_loc5_,_loc3_.length);
         _rsa.verify(_loc4_,_loc8_,_loc4_.length);
         var _loc11_:BigInteger = new BigInteger(_loc5_.toString(),10);
         var _loc12_:BigInteger = new BigInteger(_loc8_.toString(),10);
         var _loc10_:BigInteger = BigInteger.nbv(2);
         if(_loc11_.compareTo(_loc10_) <= 0 || _loc12_.compareTo(_loc11_) >= 0)
         {
            Core.crash("Invalid DH prime and generator",29);
            return;
         }
         if(_loc11_.equals(_loc12_))
         {
            Core.crash("Invalid DH prime and generator",29);
            return;
         }
         UnknownVarFromIncomingMessages_UnknownICoreCommunicationHandshake1_1 = _communication.initializeKeyExchange(_loc11_,_loc12_);
         var _loc6_:* = null;
         var _loc13_:int = 10;
         var _loc7_:String = null;
         while(_loc13_ > 0)
         {
            _loc7_ = generateRandomHexString(30);
            UnknownVarFromIncomingMessages_UnknownICoreCommunicationHandshake1_1.init(_loc7_);
            _loc9_ = UnknownVarFromIncomingMessages_UnknownICoreCommunicationHandshake1_1.getPublicKey(10);
            if(_loc9_.length >= 64)
            {
               _loc6_ = _loc9_;
               _privateKey = _loc7_;
               break;
            }
            if(_loc6_ == null || _loc9_.length > _loc6_.length)
            {
               _loc6_ = _loc9_;
               _privateKey = _loc7_;
            }
            _loc13_--;
         }
         if(_loc7_ != _privateKey)
         {
            UnknownVarFromIncomingMessages_UnknownICoreCommunicationHandshake1_1.init(_privateKey);
         }
         var _loc15_:ByteArray = new ByteArray();
         var _loc14_:ByteArray = new ByteArray();
         _loc15_.writeMultiByte(_loc6_,"iso-8859-1");
         _rsa.encrypt(_loc15_,_loc14_,_loc15_.length);
         _loc16_.sendUnencrypted(new CompleteDiffieHandshakeMessageComposer(CryptoTools.byteArrayToHexString(_loc14_)));
      }
      
      private function onCompleteDiffieHandshake(param1:IMessageEvent) : void
      {
         var _loc9_:IEncryption = null;
         var _loc7_:IConnection = param1.connection;
         var _loc4_:CompleteDiffieHandshakeEvent = param1 as CompleteDiffieHandshakeEvent;
         var _loc6_:ByteArray = new ByteArray();
         var _loc3_:ByteArray = new ByteArray();
         _loc6_.writeBytes(CryptoTools.hexStringToByteArray(_loc4_.encryptedPublicKey));
         _rsa.verify(_loc6_,_loc3_,_loc6_.length);
         _rsa.dispose();
         UnknownVarFromIncomingMessages_UnknownICoreCommunicationHandshake1_1.generateSharedKey(_loc3_.toString(),10);
         var _loc2_:String = UnknownVarFromIncomingMessages_UnknownICoreCommunicationHandshake1_1.getSharedKey(16).toUpperCase();
         if(!UnknownVarFromIncomingMessages_UnknownICoreCommunicationHandshake1_1.isValidServerPublicKey())
         {
            return;
         }
         var _loc8_:ByteArray = CryptoTools.hexStringToByteArray(_loc2_);
         _loc8_.position = 0;
         var _loc5_:IEncryption = _communication.initializeEncryption();
         _loc5_.init(_loc8_);
         if(_loc4_.serverClientEncryption)
         {
            _loc9_ = _communication.initializeEncryption();
            _loc9_.init(_loc8_);
         }
         _loc7_.setEncryption(_loc5_,_loc9_);
         _handshakeInProgress = false;
         UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_HANDSHAKED");
         UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.sendConnectionParameters(_loc7_);
      }
      
      private function onAuthenticationOK(param1:AuthenticationOKMessageEvent) : void
      {
         var _loc4_:IConnection = param1.connection;
         UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_AUTHENTICATED");
         var _loc2_:InfoRetrieveMessageComposer = new InfoRetrieveMessageComposer();
         _loc4_.send(_loc2_);
         var _loc3_:EventLogMessageComposer = new EventLogMessageComposer("Login","socket","client.auth_ok");
         _loc4_.send(_loc3_);
         var _loc5_:GetFurnitureAliasesMessageComposer = new GetFurnitureAliasesMessageComposer();
         _loc4_.send(_loc5_);
         _communication.suggestedLoginActions = param1.suggestedLoginActions;
         UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.loginOk();
      }
      
      private function onLoginFailedHotelClosed(param1:IMessageEvent) : void
      {
         var _loc2_:LoginFailedHotelClosedMessageParser = (param1 as LoginFailedHotelClosedMessageEvent).getParser();
         UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.handleLoginFailedHotelClosedMessage(_loc2_.openHour,_loc2_.openMinute);
      }
      
      private function onGenericError(param1:IMessageEvent) : void
      {
         var _loc2_:GenericErrorParser = (param1 as GenericErrorEvent).getParser();
         switch(_loc2_.errorCode)
         {
            case -3:
               UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.alert("${connection.error.id.title}","${connection.login.error.-3.desc}");
               break;
            case -400:
               UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.alert("${connection.error.id.title}","${connection.login.error.-400.desc}");
         }
      }
      
      private function onPing(param1:IMessageEvent) : void
      {
         var _loc2_:IConnection = param1.connection;
         var _loc3_:PongMessageComposer = new PongMessageComposer();
         _loc2_.send(_loc3_);
      }
      
      [SecureSWF(controlFlow="0",codeWrap="off")]
      private function onUniqueMachineId(param1:UniqueMachineIDEvent) : void
      {
         CommunicationUtils.writeSOLProperty("machineid",param1.machineID);
      }
      
      private function onIdentityAccounts(param1:IdentityAccountsEvent) : void
      {
         var _loc3_:String = null;
         var _loc6_:AvatarData = null;
         var _loc4_:Vector.<AvatarData> = new Vector.<AvatarData>(0);
         var _loc2_:Dictionary = param1.getParser().accounts;
         for(var _loc5_ in _loc2_)
         {
            _loc3_ = _loc2_[_loc5_];
            _loc6_ = new AvatarData(null);
            _loc6_.id = parseInt(_loc5_);
            _loc6_.name = _loc3_;
            _loc4_.push(_loc6_);
         }
         UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.onUserList(_loc4_);
      }
      
      private function onErrorReport(param1:IMessageEvent) : void
      {
         var _loc2_:ErrorReportMessageParser = (param1 as ErrorReportEvent).getParser();
         var _loc3_:int = _loc2_.errorCode;
         var _loc4_:int = _loc2_.messageId;
         UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.handleErrorMessage(_loc3_,_loc4_);
      }
      
      private function onConnectionEstablished(param1:Event = null) : void
      {
         var _loc2_:IConnection = _communication.connection;
         if(_loc2_ != null)
         {
            UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_ESTABLISHED");
            _logoutInProgress = false;
            _handshakeInProgress = true;
            UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_HANDSHAKING");
            _loc2_.sendUnencrypted(new ClientHelloMessageComposer());
            _loc2_.sendUnencrypted(new InitDiffieHandshakeMessageComposer());
         }
      }
      
      private function onMaintenance(param1:MaintenanceStatusMessageEvent) : void
      {
         var _loc2_:MaintenanceStatusMessageParser = param1.parser as MaintenanceStatusMessageParser;
         Logger.log("Got maintenance status, with minutes left: " + _loc2_.minutesUntilMaintenance.toString());
         UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.localization.registerParameter("disconnected.maintenance_status","%minutes%",_loc2_.minutesUntilMaintenance.toString());
         var _loc3_:String = UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.localization.getLocalization("disconnected.maintenance_status");
         UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.disconnected(-2,_loc3_);
      }
      
      private function onDisconnectReason(param1:DisconnectReasonEvent) : void
      {
         if(_handshakeInProgress)
         {
            UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL");
         }
         Logger.log("[HabboLogin] Got disconnect reason: " + param1.reason);
         UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.disconnected(param1.reason,param1.getReasonName());
         _handshakeInProgress = false;
         _logoutInProgress = true;
      }
      
      private function handleWebLogout(param1:DisconnectReasonEvent) : void
      {
         var _loc2_:String = UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.getProperty("logout.url");
         if(_loc2_.length > 0)
         {
            _loc2_ = setReasonProperty(_loc2_,param1.reasonString);
            _loc2_ = setOriginProperty(_loc2_);
            _loc2_ += "&id=" + param1.reason;
            if(UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.context.configuration.getInteger("spaweb",0) == 1)
            {
               HabboWebTools.sendDisconnectToWeb(param1.reason,param1.reasonString);
            }
            else
            {
               HabboWebTools.openWebPage(_loc2_,"_self");
            }
         }
      }
      
      private function setOriginProperty(param1:String) : String
      {
         if(param1.indexOf("%origin%") != -1)
         {
            return param1.replace("%origin%",UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.getProperty("flash.client.origin"));
         }
         return param1;
      }
      
      private function onConnectionDisconnected(param1:Event) : void
      {
         var _loc2_:String = null;
         if(UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.isRoomViewerMode)
         {
            return;
         }
         if(_handshakeInProgress)
         {
            UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.dispatchLoginStepEvent("HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL");
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.call("FlashExternalInterface.logDisconnection","Communication failure, client disconnected.");
            if(param1.type == "close" && !_logoutInProgress)
            {
               _loc2_ = UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.getProperty("logout.disconnect.url");
               _loc2_ = setOriginProperty(_loc2_);
               if(UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.context.configuration.getInteger("spaweb",0) == 1)
               {
                  HabboWebTools.sendDisconnectToWeb(-1,"HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL");
               }
               else
               {
                  HabboWebTools.openWebPage(_loc2_,"_self");
               }
            }
         }
         if(param1.type == "close" && !_logoutInProgress)
         {
            UnknownVarFromIncomingMessages_HabboCommunicationDemo_1.disconnected(-3,"");
         }
      }
      
      private function generateRandomHexString(param1:uint = 16) : String
      {
         var _loc5_:int = 0;
         var _loc4_:* = 0;
         var _loc3_:String = null;
         var _loc2_:String = "";
         _loc5_ = 0;
         while(_loc5_ < param1)
         {
            _loc4_ = Math.random() * 255;
            _loc3_ = _loc4_.toString(16);
            if(_loc3_.length < 2)
            {
               _loc3_ = "0" + _loc3_;
            }
            _loc2_ += _loc3_;
            _loc5_++;
         }
         return _loc2_;
      }
   }
}

