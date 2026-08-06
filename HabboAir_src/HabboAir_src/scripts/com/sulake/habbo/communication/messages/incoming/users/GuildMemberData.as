package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public class GuildMemberData
   {
      private var _groupId:int;
      
      private var _groupName:String;
      
      private var _baseRoomId:int;
      
      private var _badgeCode:String;
      
      private var _totalEntries:int;
      
      private var _entries:Array;
      
      private var _allowedToManage:Boolean;
      
      private var _pageSize:int;
      
      private var _pageIndex:int;
      
      private var _searchType:int;
      
      private var _userNameFilter:String;
      
      private var UnknownVarFromGuildMemberData_Dictionary_1:Dictionary;
      
      public function GuildMemberData(param1:IMessageDataWrapper)
      {
         var _loc4_:int = 0;
         var _loc3_:MemberData = null;
         UnknownVarFromGuildMemberData_Dictionary_1 = new Dictionary();
         super();
         _groupId = param1.readInteger();
         _groupName = param1.readString();
         _baseRoomId = param1.readInteger();
         _badgeCode = param1.readString();
         _totalEntries = param1.readInteger();
         _entries = [];
         var _loc2_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new MemberData(param1);
            _entries.push(_loc3_);
            UnknownVarFromGuildMemberData_Dictionary_1[_loc3_.userId] = _loc3_;
            _loc4_++;
         }
         _allowedToManage = param1.readBoolean();
         _pageSize = param1.readInteger();
         _pageIndex = param1.readInteger();
         _searchType = param1.readInteger();
         _userNameFilter = param1.readString();
      }
      
      private static function removeFromArray(param1:int, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:MemberData = null;
         while(_loc4_ < param2.length)
         {
            _loc3_ = param2[_loc4_];
            if(_loc3_.userId == param1)
            {
               param2.splice(_loc4_,1);
            }
            else
            {
               _loc4_++;
            }
         }
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function get baseRoomId() : int
      {
         return _baseRoomId;
      }
      
      public function get badgeCode() : String
      {
         return _badgeCode;
      }
      
      public function get totalEntries() : int
      {
         return _totalEntries;
      }
      
      public function get pageSize() : int
      {
         return _pageSize;
      }
      
      public function get pageIndex() : int
      {
         return _pageIndex;
      }
      
      public function get searchType() : int
      {
         return _searchType;
      }
      
      public function get entries() : Array
      {
         return _entries;
      }
      
      public function get allowedToManage() : Boolean
      {
         return _allowedToManage;
      }
      
      public function get userNameFilter() : String
      {
         return _userNameFilter;
      }
      
      public function get totalPages() : int
      {
         return Math.max(1,Math.ceil(_totalEntries / _pageSize));
      }
      
      public function update(param1:MemberData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MemberData = null;
         UnknownVarFromGuildMemberData_Dictionary_1[param1.userId] = param1;
         while(_loc3_ < _entries.length)
         {
            _loc2_ = _entries[_loc3_];
            if(_loc2_.userId == param1.userId)
            {
               _entries[_loc3_] = param1;
               return;
            }
            _loc3_++;
         }
         _entries.push(param1);
      }
      
      public function remove(param1:int) : void
      {
         removeFromArray(param1,_entries);
         delete UnknownVarFromGuildMemberData_Dictionary_1[param1];
      }
      
      public function getUser(param1:int) : MemberData
      {
         return UnknownVarFromGuildMemberData_Dictionary_1[param1];
      }
   }
}

