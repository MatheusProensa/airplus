package com.sulake.core.communication.connection
{
   import com.sulake.core.Core;
   import com.sulake.core.communication.ICoreCommunicationManager;
   import com.sulake.core.communication.encryption.IEncryption;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageConfiguration;
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.communication.messages.IPreEncryptionMessage;
   import com.sulake.core.communication.messages.MessageClassManager;
   import com.sulake.core.communication.wireformat.EvaWireFormat;
   import com.sulake.core.communication.wireformat.IEvaWireFormat;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.ClassUtils;
   import com.sulake.core.utils.ErrorReportStorage;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class SocketConnection extends EventDispatcherWrapper implements IConnection, IComponentInterfaceQueue
   {
      public static const DEFAULT_SOCKET_TIMEOUT:int = 10000;
      
      private var UnknownVarFromSocketConnection_Socket_1:Socket;
      
      private var UnknownVarFromSocketConnection_Timer_1:Timer;
      
      private var UnknownVarFromSocketConnection_Int_1:int;
      
      private var UnknownVarFromSocketConnection_ByteArray_1:ByteArray;
      
      private var UnknownVarFromSocketConnection_IEvaWireFormat_1:IEvaWireFormat;
      
      private var UnknownVarFromSocketConnection_IEncryption_1:IEncryption;
      
      private var _serverToClientEncryption:IEncryption;
      
      private var UnknownVarFromSocketConnection_MessageClassManager_1:MessageClassManager;
      
      private var _communicationManager:ICoreCommunicationManager;
      
      private var UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1:UnknownICoreCommunicationConnection1;
      
      private var UnknownVarFromSocketConnection_Boolean_1:Boolean;
      
      private var _configurationReady:Boolean;
      
      private var _pendingClientMessages:Vector.<IMessageComposer>;
      
      private var _pendingServerMessages:Vector.<IMessageDataWrapper>;
      
      private var _lastProcessedMessage:IMessageDataWrapper;
      
      public function SocketConnection(param1:ICoreCommunicationManager, param2:UnknownICoreCommunicationConnection1)
      {
         super();
         _communicationManager = param1;
         UnknownVarFromSocketConnection_MessageClassManager_1 = new MessageClassManager();
         UnknownVarFromSocketConnection_IEvaWireFormat_1 = new EvaWireFormat();
         createSocket();
         UnknownVarFromSocketConnection_Timer_1 = new Timer(10000,1);
         UnknownVarFromSocketConnection_Timer_1.addEventListener("timer",onTimeOutTimer);
         UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1 = param2;
      }
      
      private static function getKeyValue(param1:Array, param2:int) : String
      {
         var _loc5_:String = "";
         for each(var _loc3_ in param1)
         {
            for each(var _loc4_ in _loc3_)
            {
               _loc5_ += String.fromCharCode(65290 - _loc4_ + param2--);
            }
         }
         return _loc5_;
      }
      
      public function addListener(param1:String, param2:Function) : void
      {
         addEventListener(param1,param2);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            disposeSocket();
            if(UnknownVarFromSocketConnection_Timer_1)
            {
               UnknownVarFromSocketConnection_Timer_1.stop();
               UnknownVarFromSocketConnection_Timer_1.removeEventListener("timer",onTimeOutTimer);
            }
            UnknownVarFromSocketConnection_Timer_1 = null;
            UnknownVarFromSocketConnection_ByteArray_1 = null;
            UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1 = null;
            UnknownVarFromSocketConnection_IEncryption_1 = null;
            _serverToClientEncryption = null;
            UnknownVarFromSocketConnection_IEvaWireFormat_1 = null;
            if(UnknownVarFromSocketConnection_MessageClassManager_1)
            {
               UnknownVarFromSocketConnection_MessageClassManager_1.dispose();
            }
            UnknownVarFromSocketConnection_MessageClassManager_1 = null;
            _communicationManager = null;
            UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1 = null;
            _lastProcessedMessage = null;
            super.dispose();
         }
      }
      
      public function createSocket() : void
      {
         disposeSocket();
         UnknownVarFromSocketConnection_ByteArray_1 = new ByteArray();
         _serverToClientEncryption = null;
         UnknownVarFromSocketConnection_IEncryption_1 = null;
         UnknownVarFromSocketConnection_Socket_1 = new Socket();
         UnknownVarFromSocketConnection_Socket_1.addEventListener("connect",onConnect);
         UnknownVarFromSocketConnection_Socket_1.addEventListener("complete",onComplete);
         UnknownVarFromSocketConnection_Socket_1.addEventListener("close",onClose);
         UnknownVarFromSocketConnection_Socket_1.addEventListener("socketData",onRead);
         UnknownVarFromSocketConnection_Socket_1.addEventListener("securityError",onSecurityError);
         UnknownVarFromSocketConnection_Socket_1.addEventListener("ioError",onIOError);
      }
      
      private function disposeSocket() : void
      {
         if(UnknownVarFromSocketConnection_Socket_1)
         {
            UnknownVarFromSocketConnection_Socket_1.removeEventListener("connect",onConnect);
            UnknownVarFromSocketConnection_Socket_1.removeEventListener("complete",onComplete);
            UnknownVarFromSocketConnection_Socket_1.removeEventListener("close",onClose);
            UnknownVarFromSocketConnection_Socket_1.removeEventListener("socketData",onRead);
            UnknownVarFromSocketConnection_Socket_1.removeEventListener("securityError",onSecurityError);
            UnknownVarFromSocketConnection_Socket_1.removeEventListener("ioError",onIOError);
            if(UnknownVarFromSocketConnection_Socket_1.connected)
            {
               UnknownVarFromSocketConnection_Socket_1.close();
            }
            UnknownVarFromSocketConnection_Socket_1 = null;
         }
      }
      
      [SecureSWF(controlFlow="20",codeWrap="maximum",rename="true",slr="true")]
      public function init(param1:String, param2:uint = 0, param3:Boolean = true) : Boolean
      {
         if(UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1)
         {
            if(!_loc4_)
            {
               UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1.connectionInit(param1,param2);
            }
            UnknownVarFromSocketConnection_Socket_1.connect(param1 + (param3 ? "?TCP_NODELAY" : ""),param2);
            §§goto(addr66);
         }
         UnknownVarFromSocketConnection_Timer_1.start();
         UnknownVarFromSocketConnection_Int_1 = getTimer();
         if(!_loc4_)
         {
            addr66:
            if(!_loc4_)
            {
               addr79:
            }
            return true;
         }
         §§goto(addr79);
      }
      
      public function set timeout(param1:int) : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromSocketConnection_Timer_1.delay = param1;
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromSocketConnection_MessageClassManager_1.registerMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromSocketConnection_MessageClassManager_1.unregisterMessageEvent(param1);
      }
      
      public function isAuthenticated() : void
      {
         UnknownVarFromSocketConnection_Boolean_1 = true;
      }
      
      public function isConfigured() : void
      {
         var _loc1_:int = 0;
         var _loc3_:Array = null;
         _configurationReady = true;
         if(_pendingServerMessages)
         {
            for each(var _loc4_ in _pendingServerMessages)
            {
               _loc1_ = int(_loc4_.getID());
               _loc3_ = parseReceivedMessage(_loc4_);
               if(_loc3_ != null)
               {
                  handleReceivedMessage(_loc1_,_loc3_);
               }
            }
         }
         if(_pendingClientMessages)
         {
            for each(var _loc2_ in _pendingClientMessages)
            {
               send(_loc2_);
            }
            _pendingClientMessages = null;
         }
         _pendingClientMessages = new Vector.<IMessageComposer>(0);
         _pendingServerMessages = new Vector.<IMessageDataWrapper>(0);
      }
      
      [SecureSWF(controlFlow="20",codeWrap="maximum",rename="true")]
      public function send(param1:IMessageComposer) : Boolean
      {
         if(disposed)
         {
            if(!_loc5_)
            {
               §§push(false);
               if(!_loc6_)
               {
                  return §§pop();
               }
            }
            addr35:
            _pendingClientMessages = new Vector.<IMessageComposer>(0);
            if(!_loc5_)
            {
               addr46:
               _pendingClientMessages.push(param1);
            }
            §§goto(addr50);
         }
         else
         {
            §§push(UnknownVarFromSocketConnection_Boolean_1);
         }
         if(§§pop())
         {
            §§pop();
            §§push(!_configurationReady);
            if(_loc5_)
            {
            }
            addr50:
            return false;
         }
         if(§§pop())
         {
            if(_pendingClientMessages == null)
            {
               §§goto(addr35);
            }
            §§goto(addr46);
         }
         else
         {
            §§push(UnknownVarFromSocketConnection_MessageClassManager_1.getMessageIDForComposer(param1));
            if(!_loc5_)
            {
               §§push(§§pop());
            }
            var _loc4_:* = §§pop();
            if(_loc4_ < 0)
            {
               return false;
            }
            §§push(param1.getMessageArray());
            if(!_loc6_)
            {
               §§push(§§pop());
            }
            var _loc2_:* = §§pop();
            var _loc3_:ByteArray = UnknownVarFromSocketConnection_IEvaWireFormat_1.encode(_loc4_,_loc2_);
            if(UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1)
            {
               UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1.messageSent(_loc4_);
            }
            if(UnknownVarFromSocketConnection_IEncryption_1 == null)
            {
               if(!_loc6_)
               {
                  §§push(false);
                  if(!_loc5_)
                  {
                     return §§pop();
                  }
               }
               else
               {
                  §§push(true);
                  addr126:
               }
            }
            else if(UnknownVarFromSocketConnection_Socket_1.connected)
            {
               UnknownVarFromSocketConnection_IEncryption_1.encipher(_loc3_);
               if(!_loc6_)
               {
                  UnknownVarFromSocketConnection_Socket_1.writeBytes(_loc3_);
                  UnknownVarFromSocketConnection_Socket_1.flush();
               }
               §§goto(addr126);
            }
            else
            {
               §§push(false);
               if(!_loc6_)
               {
                  return §§pop();
               }
            }
            return §§pop();
         }
      }
      
      [SecureSWF(controlFlow="20",codeWrap="maximum",rename="true")]
      public function sendUnencrypted(param1:IMessageComposer) : Boolean
      {
         if(!_loc7_)
         {
            §§push(disposed);
            if(!_loc8_)
            {
               if(!§§pop())
               {
                  §§push(UnknownVarFromSocketConnection_MessageClassManager_1.getMessageIDForComposer(param1));
                  if(!_loc7_)
                  {
                     §§push(§§pop());
                  }
                  var _loc4_:* = §§pop();
                  if(_loc4_ < 0)
                  {
                     return false;
                  }
                  §§push(param1.getMessageArray());
                  if(!_loc8_)
                  {
                     §§push(§§pop());
                  }
                  var _loc2_:* = §§pop();
                  var _loc3_:ByteArray = UnknownVarFromSocketConnection_IEvaWireFormat_1.encode(_loc4_,_loc2_);
                  var _loc6_:String = getQualifiedClassName(param1);
                  var _loc5_:Class = getDefinitionByName(_loc6_) as Class;
                  §§push(ClassUtils.implementsInterface(_loc5_,IPreEncryptionMessage));
                  if(!_loc7_)
                  {
                     if(!§§pop())
                     {
                        if(!_loc7_)
                        {
                           §§push(false);
                           if(_loc7_)
                           {
                           }
                        }
                        else
                        {
                           §§push(true);
                           addr110:
                        }
                     }
                     else
                     {
                        if(UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1)
                        {
                           UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1.messageSent(_loc4_);
                        }
                        if(UnknownVarFromSocketConnection_Socket_1.connected)
                        {
                           UnknownVarFromSocketConnection_Socket_1.writeBytes(_loc3_);
                           UnknownVarFromSocketConnection_Socket_1.flush();
                           §§goto(addr110);
                        }
                        else
                        {
                           §§push(false);
                           if(!_loc7_)
                           {
                              return §§pop();
                           }
                        }
                     }
                     return §§pop();
                  }
                  return §§pop();
               }
            }
            §§goto(addr21);
         }
         addr21:
         false;
         return §§pop();
      }
      
      public function setEncryption(param1:IEncryption, param2:IEncryption) : void
      {
         UnknownVarFromSocketConnection_IEncryption_1 = param1;
         _serverToClientEncryption = param2;
      }
      
      public function registerMessageClasses(param1:IMessageConfiguration) : void
      {
         UnknownVarFromSocketConnection_MessageClassManager_1.registerMessages(param1);
      }
      
      private function processData() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         _loc1_ = splitReceivedMessages();
         for each(_lastProcessedMessage in _loc1_)
         {
            _loc2_ = _lastProcessedMessage.getID();
            if(UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1)
            {
               UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1.messageReceived(String(_loc2_));
            }
            if(UnknownVarFromSocketConnection_Boolean_1 && !_configurationReady)
            {
               if(_pendingServerMessages == null)
               {
                  _pendingServerMessages = new Vector.<IMessageDataWrapper>(0);
               }
               _pendingServerMessages.push(_lastProcessedMessage);
            }
            else
            {
               _loc3_ = parseReceivedMessage(_lastProcessedMessage);
               if(_loc3_ != null)
               {
                  handleReceivedMessage(_loc2_,_loc3_);
               }
            }
         }
      }
      
      [SecureSWF(controlFlow="0")]
      public function processReceivedData() : void
      {
         if(disposed)
         {
            return;
         }
         try
         {
            processData();
         }
         catch(e:Error)
         {
            if(UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1 && _lastProcessedMessage)
            {
               UnknownVarFromSocketConnection_UnknownICoreCommunicationConnection1_1.messageParseError(_lastProcessedMessage);
            }
            if(!disposed)
            {
               throw e;
            }
         }
      }
      
      private function splitReceivedMessages() : Array
      {
         var _loc1_:ByteArray = null;
         UnknownVarFromSocketConnection_ByteArray_1.position = 0;
         if(UnknownVarFromSocketConnection_ByteArray_1.bytesAvailable == 0)
         {
            return [];
         }
         var _loc2_:Array = UnknownVarFromSocketConnection_IEvaWireFormat_1.splitMessages(UnknownVarFromSocketConnection_ByteArray_1,this);
         if(UnknownVarFromSocketConnection_ByteArray_1.bytesAvailable == 0)
         {
            UnknownVarFromSocketConnection_ByteArray_1 = new ByteArray();
         }
         else if(UnknownVarFromSocketConnection_ByteArray_1.position > 0)
         {
            _loc1_ = new ByteArray();
            _loc1_.writeBytes(UnknownVarFromSocketConnection_ByteArray_1,UnknownVarFromSocketConnection_ByteArray_1.position);
            UnknownVarFromSocketConnection_ByteArray_1 = _loc1_;
         }
         return _loc2_;
      }
      
      private function parseReceivedMessage(param1:IMessageDataWrapper) : Array
      {
         var _loc2_:IMessageParser = null;
         var _loc3_:Array = UnknownVarFromSocketConnection_MessageClassManager_1.getMessageEventsForID(param1.getID());
         if(_loc3_ != null)
         {
            _loc2_ = (_loc3_[0] as IMessageEvent).parser;
            try
            {
               _loc2_.flush();
               _loc2_.parse(param1);
            }
            catch(e:Error)
            {
               Core.crash(getKeyValue([[65220,65192,65183,65179],[65185,65185,65252,65167],[65171,65249,65168,65182],[65164,65162,65175,65243],[65169,65163,65173,65160],[65161,65164,65158,65164],[65234,65156,65163,65148],[65147,65164,65157,65158],[65226,65140,65141,65150,65144,65150]],0) + getQualifiedClassName(_loc2_),e.errorID,e);
            }
         }
         return _loc3_;
      }
      
      private function handleReceivedMessage(param1:int, param2:Array) : void
      {
         for each(var _loc3_ in param2)
         {
            _loc3_.connection = this;
            _loc3_.callback.call(null,_loc3_);
         }
      }
      
      public function get connected() : Boolean
      {
         if(UnknownVarFromSocketConnection_Socket_1 == null)
         {
            return false;
         }
         return UnknownVarFromSocketConnection_Socket_1.connected;
      }
      
      public function close() : void
      {
         if(UnknownVarFromSocketConnection_Socket_1 == null)
         {
            return;
         }
         try
         {
            UnknownVarFromSocketConnection_Socket_1.close();
         }
         catch(e:Error)
         {
         }
      }
      
      private function onRead(param1:ProgressEvent) : void
      {
         if(UnknownVarFromSocketConnection_Socket_1 == null)
         {
            return;
         }
         UnknownVarFromSocketConnection_ByteArray_1.position = UnknownVarFromSocketConnection_ByteArray_1.length;
         UnknownVarFromSocketConnection_Socket_1.readBytes(UnknownVarFromSocketConnection_ByteArray_1,UnknownVarFromSocketConnection_ByteArray_1.position);
      }
      
      public function getServerToClientEncryption() : IEncryption
      {
         return _serverToClientEncryption;
      }
      
      private function onConnect(param1:Event) : void
      {
         UnknownVarFromSocketConnection_Timer_1.stop();
         ErrorReportStorage.addDebugData(getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65178],[65171,65171,65196,65174],[65169,65176,65162]],0),getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65182],[65182,65249,65175,65169,65246]],0) + (getTimer() - UnknownVarFromSocketConnection_Int_1));
         dispatchEvent(param1);
      }
      
      private function onClose(param1:Event) : void
      {
         UnknownVarFromSocketConnection_Timer_1.stop();
         ErrorReportStorage.addDebugData(getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65178],[65171,65171,65196,65174],[65169,65176,65162]],0),getKeyValue([[65223,65181,65177,65172],[65185,65185,65252,65178],[65172,65249]],0) + (getTimer() - UnknownVarFromSocketConnection_Int_1));
         dispatchEvent(param1);
      }
      
      private function onComplete(param1:Event) : void
      {
         UnknownVarFromSocketConnection_Timer_1.stop();
         ErrorReportStorage.addDebugData(getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65178],[65171,65171,65196,65174],[65169,65176,65162]],0),getKeyValue([[65223,65178,65179,65175],[65178,65184,65168,65182],[65182,65249,65175,65169,65246]],0) + (getTimer() - UnknownVarFromSocketConnection_Int_1));
         dispatchEvent(param1);
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         UnknownVarFromSocketConnection_Timer_1.stop();
         ErrorReportStorage.addDebugData(getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65178],[65171,65171,65196,65174],[65169,65176,65162]],0),getKeyValue([[65207,65188,65189,65170],[65172,65180,65168,65162],[65213,65167,65166,65168],[65164,65245,65171,65165,65242]],0) + (getTimer() - UnknownVarFromSocketConnection_Int_1));
         dispatchEvent(param1);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         UnknownVarFromSocketConnection_Timer_1.stop();
         ErrorReportStorage.addDebugData(getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65178],[65171,65171,65196,65174],[65169,65176,65162]],0),getKeyValue([[65217,65210,65219,65173],[65172,65174,65170,65251],[65177,65171,65248]],0) + (getTimer() - UnknownVarFromSocketConnection_Int_1));
         switch(param1.type)
         {
            case "ioError":
            case "diskError":
            case "networkError":
            case "verifyError":
         }
         dispatchEvent(param1);
      }
      
      private function onTimeOutTimer(param1:TimerEvent) : void
      {
         UnknownVarFromSocketConnection_Timer_1.stop();
         ErrorReportStorage.addDebugData(getKeyValue([[65223,65178,65178,65177],[65185,65186,65168,65178],[65171,65171,65196,65174],[65169,65176,65162]],0),getKeyValue([[65206,65184,65179,65186],[65207,65168,65168,65251],[65177,65171,65248,65247]],0) + (getTimer() - UnknownVarFromSocketConnection_Int_1));
         var _loc2_:IOErrorEvent = new IOErrorEvent("ioError");
         _loc2_.text = getKeyValue([[65207,65178,65189,65180],[65185,65169,65252,65199],[65177,65172,65179,65168],[65161,65161,65244,65235]],0) + UnknownVarFromSocketConnection_Timer_1.delay + getKeyValue([[65258,65180,65173,65246],[65240,65253,65204,65172],[65167,65166,65175,65181],[65170,65176,65244,65205],[65169,65159,65171,65152],[65173,65161,65160,65221]],0);
         dispatchEvent(_loc2_);
      }
   }
}

