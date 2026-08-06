package com.sulake.habbo.communication
{
   import com.hurlant.math.BigInteger;
   import com.sulake.core.Core;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.ICoreCommunicationManager;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.connection.UnknownICoreCommunicationConnection1;
   import com.sulake.core.communication.encryption.IEncryption;
   import com.sulake.core.communication.handshake.UnknownICoreCommunicationHandshake1;
   import com.sulake.core.communication.messages.IMessageConfiguration;
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.habbo.communication.encryption.ArcFour;
   import com.sulake.habbo.communication.encryption.DiffieHellman;
   import com.sulake.habbo.communication.messages.outgoing.handshake.DisconnectMessageComposer;
   import com.sulake.iid.IIDCoreCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class HabboCommunicationManager extends Component implements IHabboCommunicationManager, UnknownICoreCommunicationConnection1
   {
      private static const DEFAULT_CONNECTION_ATTEMPTS:int = 2;
      
      private var _communication:ICoreCommunicationManager;
      
      private var _messages:IMessageConfiguration = new HabboMessages();
      
      private var UnknownVarFromHabboCommunicationManager_String_1:String = "";
      
      private var UnknownVarFromHabboCommunicationManager_Array_1:Array = [];
      
      private var UnknownVarFromHabboCommunicationManager_Boolean_1:Boolean = true;
      
      private var UnknownVarFromHabboCommunicationManager_Int_1:int = -1;
      
      private var UnknownVarFromHabboCommunicationManager_Timer_1:Timer = new Timer(100,1);
      
      private var UnknownVarFromHabboCommunicationManager_Int_2:int = 1;
      
      private var UnknownVarFromHabboCommunicationManager_String_2:String = "";
      
      private var UnknownVarFromHabboCommunicationManager_Boolean_2:Boolean = false;
      
      private var UnknownVarFromHabboCommunicationManager_Boolean_3:Boolean = false;
      
      private var _a4:Array = [65191,65178,65178,65177,65185];
      
      private var _suggestedLoginActions:Array = [];
      
      private var _habboWebApiSession:IHabboWebApiSession_3;
      
      private var _connection:IConnection;
      
      private var _mode:int = 0;
      
      private var _requiresInitialRetryAttempt:Boolean = true;
      
      public function HabboCommunicationManager(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         param1.events.addEventListener("unload",unloading);
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
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDCoreCommunicationManager(),function(param1:ICoreCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboConfigurationManager(),null,false,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }])]);
      }
      
      private function onAuthenticated(param1:Event) : void
      {
         _connection.isAuthenticated();
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         _connection.isConfigured();
      }
      
      public function disconnect() : void
      {
         if(_connection)
         {
            _connection.close();
         }
      }
      
      public function get connection() : IConnection
      {
         return _connection;
      }
      
      public function get mode() : int
      {
         return 0;
      }
      
      public function set mode(param1:int) : void
      {
         _mode = param1;
      }
      
      public function get port() : int
      {
         if(UnknownVarFromHabboCommunicationManager_Array_1.length == 0 || UnknownVarFromHabboCommunicationManager_Int_1 < 0 || UnknownVarFromHabboCommunicationManager_Int_1 >= UnknownVarFromHabboCommunicationManager_Array_1.length)
         {
            return 0;
         }
         return UnknownVarFromHabboCommunicationManager_Array_1[UnknownVarFromHabboCommunicationManager_Int_1];
      }
      
      public function get suggestedLoginActions() : Array
      {
         return _suggestedLoginActions;
      }
      
      public function set suggestedLoginActions(param1:Array) : void
      {
         _suggestedLoginActions = param1;
      }
      
      override protected function initComponent() : void
      {
         context.events.addEventListener("HABBO_CONNECTION_EVENT_AUTHENTICATED",onAuthenticated);
         _connection = _communication.createConnection(this);
         _connection.registerMessageClasses(_messages);
         _connection.addListener("ioError",onIOError);
         _connection.addListener("securityError",onSecurityError);
         _connection.addListener("connect",onConnect);
         updateHostParameters();
         if(UnknownVarFromHabboCommunicationManager_Boolean_3)
         {
            nextPort();
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_connection)
         {
            _connection.dispose();
            _connection = null;
         }
         if(_habboWebApiSession)
         {
            _habboWebApiSession.dispose();
            _habboWebApiSession = null;
         }
         super.dispose();
      }
      
      public function updateHostParameters() : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = 0;
         §§push([65162,65162,65158,65155]);
         if(!_loc13_)
         {
            §§push(§§pop());
         }
         var _loc10_:* = §§pop();
         §§push([65234,65174,65168,65175,65165,65229]);
         if(!_loc14_)
         {
            §§push(§§pop());
         }
         var _loc9_:* = §§pop();
         §§push([65170,65162,65157,65155]);
         if(!_loc13_)
         {
            §§push(§§pop());
         }
         var _loc2_:* = §§pop();
         §§push([65186,65168,65178,65171,65171]);
         if(!_loc13_)
         {
            §§push(§§pop());
         }
         var _loc1_:* = §§pop();
         §§push(getProperty(getKeyValue([_a4,_loc1_,_loc9_,_loc2_],0),null));
         if(!_loc13_)
         {
            §§push(§§pop());
         }
         var _loc5_:* = §§pop();
         if(_loc5_ == null)
         {
            if(!_loc14_)
            {
               Core.crash(getKeyValue([_a4,_loc1_,_loc9_,_loc2_],0),30);
            }
            return;
         }
         §§push([]);
         if(!_loc14_)
         {
            §§push(§§pop());
         }
         _loc4_ = §§pop();
         if(!_loc13_)
         {
            §§push(1);
            if(!_loc13_)
            {
               _loc7_ = §§pop();
               if(!_loc14_)
               {
                  while(true)
                  {
                     §§push(_loc7_);
                  }
               }
            }
            while(§§pop() < 5)
            {
               §§push(_loc5_);
               if(!_loc13_)
               {
                  §§push(§§pop().substring(0,_loc5_.length - _loc7_));
               }
               _loc5_ = §§pop();
               if(!_loc13_)
               {
                  §§push(_loc7_);
                  if(!_loc14_)
                  {
                     §§push(§§pop());
                     if(!_loc14_)
                     {
                        §§push(§§pop() - 1);
                     }
                  }
                  switch(§§pop())
                  {
                     case 0:
                        addr183:
                        _loc4_.push(_a4);
                        addr182:
                        if(!_loc13_)
                        {
                           break;
                        }
                        continue;
                     case 1:
                        §§push(_loc4_);
                        if(!_loc14_)
                        {
                           §§push(_loc1_);
                           if(!_loc13_)
                           {
                              §§pop().push(§§pop());
                              if(_loc13_)
                              {
                              }
                              break;
                           }
                        }
                        else
                        {
                           §§goto(addr182);
                        }
                        §§goto(addr183);
                     case 2:
                        §§push(_loc4_);
                        if(!_loc14_)
                        {
                           §§push(_loc9_);
                           if(!_loc14_)
                           {
                              §§pop().push(§§pop());
                              if(_loc14_)
                              {
                              }
                              break;
                           }
                        }
                        else
                        {
                           addr173:
                           §§push(_loc10_);
                           if(!_loc13_)
                           {
                              §§pop().push(§§pop());
                              if(_loc14_)
                              {
                              }
                              break;
                           }
                        }
                        §§goto(addr183);
                     case 3:
                        §§push(_loc4_);
                        if(!_loc14_)
                        {
                           §§goto(addr173);
                        }
                        else
                        {
                           §§goto(addr183);
                        }
                  }
                  addr187:
                  _loc7_++;
                  continue;
               }
               §§goto(addr187);
            }
         }
         §§push(getProperty(getKeyValue(_loc4_,0),null));
         if(!_loc14_)
         {
            §§push(§§pop());
         }
         _loc6_ = §§pop();
         if(!_loc14_)
         {
            §§push(_loc6_);
            if(!_loc13_)
            {
               if(§§pop() == null)
               {
                  if(!_loc13_)
                  {
                     Core.crash(getKeyValue([_a4,_loc1_,_loc9_,_loc10_],0),30);
                     if(!_loc14_)
                     {
                        return;
                     }
                  }
               }
               else
               {
                  UnknownVarFromHabboCommunicationManager_Array_1 = [];
               }
            }
            §§goto(addr234);
         }
         addr234:
         var _loc8_:Array = §§pop().split(",");
         var _loc12_:int = 0;
         var _loc11_:* = _loc8_;
         if(!_loc14_)
         {
            for each(var _loc3_ in _loc11_)
            {
               if(!_loc14_)
               {
                  UnknownVarFromHabboCommunicationManager_Array_1.push(parseInt(_loc3_.replace(" ","")));
               }
            }
            if(_loc13_)
            {
            }
            §§goto(addr281);
         }
         UnknownVarFromHabboCommunicationManager_String_1 = _loc5_;
         addr281:
         return;
         §§push(_loc6_);
      }
      
      public function renewSocket() : void
      {
         UnknownVarFromHabboCommunicationManager_Int_2 = 1;
         _requiresInitialRetryAttempt = true;
         if(_connection != null)
         {
            _connection.createSocket();
         }
      }
      
      public function initConnection(param1:String) : void
      {
         var _loc2_:* = param1;
         if("habbo" === _loc2_)
         {
            if(_connection == null)
            {
               Core.crash("Tried to connect to proxy but connection was null",30);
               return;
            }
            UnknownVarFromHabboCommunicationManager_Boolean_3 = true;
            if(allRequiredDependenciesInjected)
            {
               nextPort();
            }
         }
      }
      
      public function addHabboConnectionMessageEvent(param1:IMessageEvent) : IMessageEvent
      {
         if(_connection)
         {
            _connection.addMessageEvent(param1);
         }
         return param1;
      }
      
      public function removeHabboConnectionMessageEvent(param1:IMessageEvent) : void
      {
         if(_connection)
         {
            _connection.removeMessageEvent(param1);
         }
      }
      
      public function connectionInit(param1:String, param2:int) : void
      {
         ErrorReportStorage.setParameter("host",param1);
         ErrorReportStorage.setParameter("port",String(param2));
      }
      
      public function messageReceived(param1:String) : void
      {
         ErrorReportStorage.setParameter("rece_msg_time",String(new Date().getTime()));
         if(UnknownVarFromHabboCommunicationManager_String_2.length > 0)
         {
            UnknownVarFromHabboCommunicationManager_String_2 += ",R:" + param1;
         }
         else
         {
            UnknownVarFromHabboCommunicationManager_String_2 = "R:" + param1;
         }
         if(UnknownVarFromHabboCommunicationManager_String_2.length > 150)
         {
            UnknownVarFromHabboCommunicationManager_String_2 = UnknownVarFromHabboCommunicationManager_String_2.substring(UnknownVarFromHabboCommunicationManager_String_2.length - 150);
         }
      }
      
      public function messageSent(param1:String) : void
      {
         ErrorReportStorage.setParameter("sent_msg_time",String(new Date().getTime()));
         if(UnknownVarFromHabboCommunicationManager_String_2.length > 0)
         {
            UnknownVarFromHabboCommunicationManager_String_2 += ",S:" + param1;
         }
         else
         {
            UnknownVarFromHabboCommunicationManager_String_2 = "S:" + param1;
         }
         if(UnknownVarFromHabboCommunicationManager_String_2.length > 150)
         {
            UnknownVarFromHabboCommunicationManager_String_2 = UnknownVarFromHabboCommunicationManager_String_2.substring(UnknownVarFromHabboCommunicationManager_String_2.length - 150);
         }
      }
      
      public function messageParseError(param1:IMessageDataWrapper) : void
      {
         ErrorReportStorage.setParameter("sent_msg_data",(param1 as Object).toString());
         ErrorReportStorage.addDebugData("MESSAGE_QUEUE",UnknownVarFromHabboCommunicationManager_String_2);
      }
      
      public function setMessageQueueErrorDebugData() : void
      {
         ErrorReportStorage.addDebugData("MESSAGE_QUEUE",UnknownVarFromHabboCommunicationManager_String_2);
      }
      
      public function initializeEncryption() : IEncryption
      {
         return new ArcFour();
      }
      
      public function set tcpNoDelay(param1:Boolean) : void
      {
         UnknownVarFromHabboCommunicationManager_Boolean_1 = param1;
      }
      
      public function initializeKeyExchange(param1:BigInteger, param2:BigInteger) : UnknownICoreCommunicationHandshake1
      {
         return new DiffieHellman(param1,param2);
      }
      
      private function nextPort() : void
      {
         var _loc1_:int = 0;
         if(!_connection)
         {
            return;
         }
         if(_connection.connected)
         {
            return;
         }
         UnknownVarFromHabboCommunicationManager_Int_1++;
         if(UnknownVarFromHabboCommunicationManager_Int_1 >= UnknownVarFromHabboCommunicationManager_Array_1.length)
         {
            ErrorReportStorage.addDebugData("ConnectionRetry","Connection attempt " + UnknownVarFromHabboCommunicationManager_Int_2);
            UnknownVarFromHabboCommunicationManager_Int_2++;
            _loc1_ = 2;
            if(UnknownVarFromHabboCommunicationManager_Array_1.length == 1)
            {
               _loc1_++;
            }
            if(UnknownVarFromHabboCommunicationManager_Int_2 > _loc1_)
            {
               if(UnknownVarFromHabboCommunicationManager_Boolean_2)
               {
                  return;
               }
               UnknownVarFromHabboCommunicationManager_Boolean_2 = true;
               Core.error("Connection failed to host and ports",true,30);
               return;
            }
            UnknownVarFromHabboCommunicationManager_Int_1 = 0;
         }
         _connection.timeout = UnknownVarFromHabboCommunicationManager_Int_2 * 10000;
         _connection.init(UnknownVarFromHabboCommunicationManager_String_1 + getKeyValue([[65244,65185,65191,65189,65188],[65174,65238,65184],[65171,65172]],0),UnknownVarFromHabboCommunicationManager_Array_1[UnknownVarFromHabboCommunicationManager_Int_1],UnknownVarFromHabboCommunicationManager_Boolean_1);
         if(_requiresInitialRetryAttempt)
         {
            UnknownVarFromHabboCommunicationManager_Int_1--;
            _requiresInitialRetryAttempt = false;
         }
      }
      
      private function tryNextPort() : void
      {
         UnknownVarFromHabboCommunicationManager_Timer_1.addEventListener("timer",onTryNextPort);
         UnknownVarFromHabboCommunicationManager_Timer_1.start();
      }
      
      private function unloading(param1:Event) : void
      {
         if(_connection)
         {
            _connection.send(new DisconnectMessageComposer());
         }
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         switch(param1.type)
         {
            case "ioError":
            case "diskError":
            case "networkError":
            case "verifyError":
         }
         ErrorReportStorage.addDebugData("Communication IO Error","IOError " + param1.type + " on connect: " + param1.text + ". Port was " + UnknownVarFromHabboCommunicationManager_Array_1[UnknownVarFromHabboCommunicationManager_Int_1]);
         tryNextPort();
      }
      
      private function onConnect(param1:Event) : void
      {
         ErrorReportStorage.addDebugData("Connection","Connected with " + UnknownVarFromHabboCommunicationManager_Int_2 + " attempts");
      }
      
      private function onTryNextPort(param1:TimerEvent) : void
      {
         nextPort();
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
         ErrorReportStorage.addDebugData("Communication Security Error","SecurityError on connect: " + param1.text + ". Port was " + UnknownVarFromHabboCommunicationManager_Array_1[UnknownVarFromHabboCommunicationManager_Int_1]);
         tryNextPort();
      }
      
      public function createHabboWebApiSession(param1:IHabboWebApiSession_1, param2:String) : IHabboWebApiSession_3
      {
         if(_habboWebApiSession != null)
         {
            resetHabboWebApiSession();
         }
         var _loc3_:HabboWebApiSession = new HabboWebApiSession(param2);
         _loc3_.addListener(param1);
         _habboWebApiSession = _loc3_;
         events.dispatchEvent(new Event("HABBO_POCKET_SESSION_CREATED"));
         return _loc3_;
      }
      
      public function getHabboWebApiSession() : IHabboWebApiSession_3
      {
         return _habboWebApiSession;
      }
      
      public function resetHabboWebApiSession() : void
      {
         if(_habboWebApiSession)
         {
            _habboWebApiSession.dispose();
            _habboWebApiSession = null;
         }
      }
   }
}

