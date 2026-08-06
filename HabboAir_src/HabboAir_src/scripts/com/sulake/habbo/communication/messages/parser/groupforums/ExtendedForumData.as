package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class ExtendedForumData extends ForumData
   {
      private var _readPermissions:int;
      
      private var _postMessagePermissions:int;
      
      private var _postThreadPermissions:int;
      
      private var _moderatePermissions:int;
      
      private var _readPermissionError:String;
      
      private var _postMessagePermissionError:String;
      
      private var _postThreadPermissionError:String;
      
      private var _moderatePermissionError:String;
      
      private var _reportPermissionError:String;
      
      private var _canChangeSettings:Boolean;
      
      private var _isStaff:Boolean;
      
      public function ExtendedForumData()
      {
         super();
      }
      
      public static function readFromMessage(param1:IMessageDataWrapper) : ExtendedForumData
      {
         var _loc2_:ExtendedForumData = new ExtendedForumData();
         ForumData.fillFromMessage(_loc2_,param1);
         _loc2_._readPermissions = param1.readInteger();
         _loc2_._postMessagePermissions = param1.readInteger();
         _loc2_._postThreadPermissions = param1.readInteger();
         _loc2_._moderatePermissions = param1.readInteger();
         _loc2_._readPermissionError = param1.readString();
         _loc2_._postMessagePermissionError = param1.readString();
         _loc2_._postThreadPermissionError = param1.readString();
         _loc2_._moderatePermissionError = param1.readString();
         _loc2_._reportPermissionError = param1.readString();
         _loc2_._canChangeSettings = param1.readBoolean();
         _loc2_._isStaff = param1.readBoolean();
         return _loc2_;
      }
      
      public function get readPermissions() : int
      {
         return _readPermissions;
      }
      
      public function get postMessagePermissions() : int
      {
         return _postMessagePermissions;
      }
      
      public function get postThreadPermissions() : int
      {
         return _postThreadPermissions;
      }
      
      public function get moderatePermissions() : int
      {
         return _moderatePermissions;
      }
      
      public function get canRead() : Boolean
      {
         return _readPermissionError.length == 0;
      }
      
      public function get canReport() : Boolean
      {
         return true;
      }
      
      public function get canPostMessage() : Boolean
      {
         return _postMessagePermissionError.length == 0;
      }
      
      public function get canPostThread() : Boolean
      {
         return _postThreadPermissionError.length == 0;
      }
      
      public function get canModerate() : Boolean
      {
         return _moderatePermissionError.length == 0;
      }
      
      public function get canChangeSettings() : Boolean
      {
         return _canChangeSettings;
      }
      
      public function get isStaff() : Boolean
      {
         return _isStaff;
      }
      
      public function get readPermissionError() : String
      {
         return _readPermissionError;
      }
      
      public function get postMessagePermissionError() : String
      {
         return _postMessagePermissionError;
      }
      
      public function get postThreadPermissionError() : String
      {
         return _postThreadPermissionError;
      }
      
      public function get moderatePermissionError() : String
      {
         return _moderatePermissionError;
      }
      
      public function get reportPermissionError() : String
      {
         return _reportPermissionError;
      }
   }
}

