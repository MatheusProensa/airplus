package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.DisconnectReasonParser;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   
   [SecureSWF(rename="true")]
   public class DisconnectReasonEvent extends MessageEvent implements IMessageEvent
   {
      public static const UNKNOWN_REASON:int = -1;
      
      public static const MAINTENANCE_BREAK:int = -2;
      
      public static const CONNECTION_CLOSED:int = -3;
      
      public static const LOGOUT:int = 0;
      
      public static const JUST_BANNED:int = 1;
      
      public static const CONCURRENT_LOGIN:int = 2;
      
      public static const CONNECTION_LOST_TO_PEER:int = 3;
      
      public static const AVATAR_IDENTITY_CHANGE:int = 4;
      
      public static const REMOVE_FURNITURE_TOOL:int = 5;
      
      public static const STILL_BANNED:int = 10;
      
      public static const DUAL_LOGIN_BY_USERID:int = 11;
      
      public static const HOTEL_CLOSED:int = 12;
      
      public static const DUAL_LOGIN_BY_IP:int = 13;
      
      public static const PEER_CONNECTION_MISSING:int = 16;
      
      public static const NO_LOGIN_PERMISSION:int = 17;
      
      public static const DUPLICATE_CONNECTION:int = 18;
      
      public static const HOTEL_CLOSING:int = 19;
      
      public static const INCORRECT_PASSWORD:int = 20;
      
      public static const INVALID_LOGIN_TICKET:int = 22;
      
      public static const VERSION_CHECK_URL:int = 23;
      
      public static const VERSION_CHECK_PROPERTY:int = 24;
      
      public static const VERSION_CHECK_MACHINE_ID:int = 25;
      
      public static const NO_MESSENGER_SESSION:int = 26;
      
      public static const USER_NOT_FOUND:int = 27;
      
      public static const CRYPTO_NOT_INITIALIZED:int = 28;
      
      public static const DEV_CRYPTO_NOT_ALLOWED:int = 29;
      
      public static const DUPLICATE_UUID_DETECTED:int = 100;
      
      public static const OLD_SESSION_IN_PROXY:int = 101;
      
      public static const PUBLIC_KEY_NOT_NUMERIC:int = 102;
      
      public static const PUBLIC_KEY_TOO_SHORT:int = 103;
      
      public static const SOCKET_READ_GENERIC:int = 104;
      
      public static const SOCKET_READ_FIRST_BYTE:int = 105;
      
      public static const SOCKET_READ_LENGTH:int = 106;
      
      public static const SOCKET_READ_BODY:int = 107;
      
      public static const SOCKET_READ_POLICY:int = 108;
      
      public static const SOCKET_IO_EXCEPTION:int = 109;
      
      public static const SOCKET_WRONG_CRYPTO:int = 110;
      
      public static const PROXY_RUNTIME_EXCEPTION:int = 111;
      
      public static const IDLE_CONNECTION:int = 112;
      
      public static const PONG_TIMEOUT:int = 113;
      
      public static const IDLE_CONNECTION_NOT_AUTH:int = 114;
      
      public static const IDLE_CONNECTION_NO_USER_ID:int = 115;
      
      public static const WRITE_CLOSED_CHANNEL:int = 116;
      
      public static const SOCKET_WRITE_EXCEPTION_1:int = 117;
      
      public static const SOCKET_WRITE_EXCEPTION_2:int = 118;
      
      public static const SOCKET_WRITE_EXCEPTION_3:int = 119;
      
      public static const TOO_MANY_BYTES_PENDING_WRITE:int = 120;
      
      public static const IDLE_CONNECTION_POLICY_REQUEST:int = 121;
      
      public static const INCOMPATIBLE_CLIENT_VERSION:int = 122;
      
      public static const CREDENTIALS_REMOVED:int = 123;
      
      public static const INSUFFICIENT_SECURITY_LEVEL:int = 124;
      
      public static const TOO_MANY_UNDEFINED_CLIENT_MESSAGES:int = 125;
      
      public static const INVALID_PARAMETER_RANGE:int = 126;
      
      private static var UnknownVarFromDisconnectReasonEvent_Dictionary_1:Dictionary;
      
      public function DisconnectReasonEvent(param1:Function)
      {
         super(param1,DisconnectReasonParser);
      }
      
      public static function resolveDisconnectedReasonLocalizationKey(param1:int) : String
      {
         switch(param1)
         {
            case -2:
               return "${disconnected.maintenance}";
            case 0:
               return "${disconnected.logged_out}";
            case 1:
               return "${disconnected.just_banned}";
            case 10:
               return "${disconnected.still_banned}";
            case 2:
            case 13:
            case 11:
            case 18:
               return "${disconnected.concurrent_login}";
            case 12:
            case 19:
               return "${disconnected.hotel_closed}";
            case 20:
               return "${disconnected.incorrect_password}";
            case 112:
               return "${disconnected.idle}";
            case 122:
               return "${disconnected.incompatible_client_version}";
            case 4:
            case 5:
            case 16:
            case 17:
            case 22:
            case 23:
            case 24:
            case 25:
            case 26:
            case 27:
            case 28:
            case 29:
            case 100:
            case 101:
            case 102:
            case 103:
            case 104:
            case 105:
            case 106:
            case 107:
            case 108:
            case 109:
            case 110:
            case 111:
            case 113:
            case 114:
            case 115:
            case 116:
            case 117:
            case 118:
            case 119:
            case 120:
            case 121:
            case 123:
            case 124:
            case 125:
            case 126:
               break;
            default:
               return "${disconnected.generic}";
         }
         return "${disconnected.generic}";
      }
      
      public function get reason() : int
      {
         return (this._parser as DisconnectReasonParser).reason;
      }
      
      public function get reasonString() : String
      {
         switch(reason)
         {
            case 1:
            case 10:
               break;
            case 2:
               return "concurrentlogin";
            case 20:
               return "incorrectpassword";
            default:
               return "logout";
         }
         return "banned";
      }
      
      public function getReasonName() : String
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(UnknownVarFromDisconnectReasonEvent_Dictionary_1 == null)
         {
            UnknownVarFromDisconnectReasonEvent_Dictionary_1 = new Dictionary();
            _loc2_ = describeType(DisconnectReasonEvent);
            for each(var _loc1_ in _loc2_.constant)
            {
               _loc3_ = _loc1_.@name;
               _loc4_ = DisconnectReasonEvent[_loc1_.@name];
               UnknownVarFromDisconnectReasonEvent_Dictionary_1[_loc4_] = _loc3_;
            }
         }
         return UnknownVarFromDisconnectReasonEvent_Dictionary_1[reason];
      }
   }
}

