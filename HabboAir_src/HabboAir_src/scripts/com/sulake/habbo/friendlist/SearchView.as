package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.*;
   import com.sulake.habbo.communication.messages.incoming.friendlist.HabboSearchResultData;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.HabboSearchMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.friendlist.domain.AvatarSearchResults;
   import com.sulake.habbo.utils.ExtendedProfileIcon;
   
   public class SearchView implements ITabView, ISearchView
   {
      private var _friendList:HabboFriendList;
      
      private var _searchStr:ITextFieldWindow;
      
      private var UnknownVarFromSearchView_IItemListWindow_1:IItemListWindow;
      
      public function SearchView()
      {
         super();
      }
      
      public function init(param1:HabboFriendList) : void
      {
         _friendList = param1;
      }
      
      public function getEntryCount() : int
      {
         if(_friendList.searchResults.friends == null)
         {
            return 0;
         }
         return _friendList.searchResults.friends.length + _friendList.searchResults.others.length;
      }
      
      public function fillList(param1:IItemListWindow) : void
      {
         UnknownVarFromSearchView_IItemListWindow_1 = param1;
      }
      
      public function fillFooter(param1:IWindowController_1) : void
      {
         _searchStr = ITextFieldWindow(param1.findChildByName("search_str"));
         _searchStr.procedure = onSearchInput;
         _searchStr.addEventListener("WKE_KEY_DOWN",onSearchStrInput);
         param1.findChildByName("search_but").procedure = onSearchButtonClick;
         _friendList.refreshButton(param1,"search",true,null,0);
      }
      
      public function tabClicked(param1:int) : void
      {
      }
      
      public function refreshList() : void
      {
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc3_:HabboSearchResultData = null;
         var _loc6_:HabboSearchResultData = null;
         var _loc1_:Boolean = false;
         UnknownVarFromSearchView_IItemListWindow_1.autoArrangeItems = false;
         var _loc2_:AvatarSearchResults = _friendList.searchResults;
         _loc4_ = 0;
         while(true)
         {
            _loc5_ = _friendList.isMessagesPersisted();
            if(_loc4_ == 0)
            {
               refreshEntry(true,_loc4_,null,null,getFriendsCaption(),false,false,0);
            }
            else if(_loc4_ <= _loc2_.friends.length)
            {
               _loc3_ = _loc2_.friends[_loc4_ - 1];
               refreshEntry(true,_loc4_,_loc3_.avatarFigure,_loc3_.avatarName,null,_loc3_.isAvatarOnline || _loc5_,false,_loc3_.avatarId);
            }
            else if(_loc4_ == _loc2_.friends.length + 1)
            {
               refreshEntry(true,_loc4_,null,null,getOthersCaption(),false,false,0);
            }
            else if(_loc4_ <= _loc2_.friends.length + _loc2_.others.length + 1)
            {
               _loc6_ = _loc2_.others[_loc4_ - 2 - _loc2_.friends.length];
               refreshEntry(true,_loc4_,_loc6_.avatarFigure,_loc6_.avatarName,null,false,_loc6_.avatarId != _friendList.avatarId && !_friendList.searchResults.isFriendRequestSent(_loc6_.avatarId),_loc6_.avatarId);
            }
            else
            {
               _loc1_ = refreshEntry(false,_loc4_,null,null,null,false,false,0);
               if(_loc1_)
               {
                  break;
               }
            }
            _loc4_++;
         }
         refreshShading();
         UnknownVarFromSearchView_IItemListWindow_1.autoArrangeItems = true;
      }
      
      private function refreshShading() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromSearchView_IItemListWindow_1.numListItems)
         {
            UnknownVarFromSearchView_IItemListWindow_1.getListItemAt(_loc1_).color = _friendList.laf.getRowShadingColor(3,_loc1_ % 2 == 1);
            _loc1_++;
         }
      }
      
      public function setSearchStr(param1:String) : void
      {
         this._searchStr.text = param1;
      }
      
      public function focus() : void
      {
         this._searchStr.focus();
      }
      
      private function getFriendsCaption() : String
      {
         if(_friendList.searchResults.friends.length == 0)
         {
            return "${friendlist.search.nofriendsfound}";
         }
         _friendList.registerParameter("friendlist.search.friendscaption","cnt","" + _friendList.searchResults.friends.length);
         return "${friendlist.search.friendscaption}";
      }
      
      private function getOthersCaption() : String
      {
         if(_friendList.searchResults.others.length == 0)
         {
            return "${friendlist.search.noothersfound}";
         }
         _friendList.registerParameter("friendlist.search.otherscaption","cnt","" + _friendList.searchResults.others.length);
         return "${friendlist.search.otherscaption}";
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:String, param4:String, param5:String, param6:Boolean, param7:Boolean, param8:int) : Boolean
      {
         var _loc9_:IWindowController_1 = UnknownVarFromSearchView_IItemListWindow_1.getListItemAt(param2) as IWindowController_1;
         if(_loc9_ == null)
         {
            if(!param1)
            {
               return true;
            }
            _loc9_ = IWindowController_1(_friendList.getXmlWindow("search_entry"));
            _loc9_.findChildByName("bg_region").procedure = onSearchEntry;
            UnknownVarFromSearchView_IItemListWindow_1.addListItem(_loc9_);
         }
         if(param1)
         {
            _loc9_.height = 20;
            _loc9_.visible = true;
         }
         else
         {
            _loc9_.height = 0;
            _loc9_.visible = false;
         }
         _loc9_.id = param8;
         _loc9_.findChildByName("bg_region").id = param8;
         refreshFigure(_loc9_,param3,param8 < 0);
         _friendList.refreshText(_loc9_,"name",param4 != null,param4);
         _friendList.refreshText(_loc9_,"caption",param5 != null,param5);
         _friendList.refreshButton(_loc9_,"start_chat",param6,onChatButtonClick,param8);
         _friendList.refreshButton(_loc9_,"ask_for_friend",param7,onAskForFriendButtonClick,param8);
         ExtendedProfileIcon.setUserInfoState(false,_loc9_);
         _loc9_.findChildByName("user_info_region").visible = param8 > 0;
         return false;
      }
      
      private function refreshFigure(param1:IWindowController_1, param2:String, param3:Boolean = false) : void
      {
         var _loc4_:IBitmapWrapperController = param1.getChildByName("face") as IBitmapWrapperController;
         if(param2 == null || param2 == "")
         {
            _loc4_.visible = false;
         }
         else
         {
            if(param3)
            {
               _loc4_.bitmap = _friendList.getSmallGroupBadgeBitmap(param2);
            }
            else
            {
               _loc4_.bitmap = _friendList.getAvatarFaceBitmap(param2);
            }
            _loc4_.width = _loc4_.bitmap.width;
            _loc4_.height = _loc4_.bitmap.height;
            _loc4_.visible = true;
         }
      }
      
      private function onSearchEntry(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param2.id < 1)
         {
            return;
         }
         _friendList.view.showInfo(param1,"${infostand.profile.link.tooltip}");
         if(param1.type == "WME_OVER")
         {
            ExtendedProfileIcon.setUserInfoState(true,IWindowController_1(param2.parent));
         }
         else if(param1.type == "WME_OUT")
         {
            ExtendedProfileIcon.setUserInfoState(false,IWindowController_1(param2.parent));
         }
         else if(param1.type == "WME_CLICK")
         {
            _friendList.trackGoogle("extendedProfile","friendList_friendsSearch");
            _friendList.send(new GetExtendedProfileMessageComposer(param2.id));
         }
      }
      
      private function onSearchButtonClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.search}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         Logger.log("Search clicked: " + param2.name);
         searchAvatar();
      }
      
      private function onAskForFriendButtonClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.addfriend}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         Logger.log("Ask for friend clicked: " + param2.id);
         var _loc3_:HabboSearchResultData = this._friendList.searchResults.getResult(param2.id);
         if(_loc3_ == null)
         {
            Logger.log("No search result found with id: " + param2.id);
            return;
         }
         Logger.log("Search result found: " + _loc3_.avatarName);
         var _loc4_:Boolean = this._friendList.askForAFriend(_loc3_.avatarId,_loc3_.avatarName);
         if(!_loc4_)
         {
            _friendList.showLimitReachedAlert();
         }
         else
         {
            _friendList.showFriendRequestSentAlert(_loc3_.avatarName);
            refreshEntry(true,findIndexFor(_loc3_.avatarId),_loc3_.avatarFigure,_loc3_.avatarName,null,false,false,_loc3_.avatarId);
         }
      }
      
      private function findIndexFor(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromSearchView_IItemListWindow_1.numListItems)
         {
            if(UnknownVarFromSearchView_IItemListWindow_1.getListItemAt(_loc2_).id == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function onChatButtonClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.im}");
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:HabboSearchResultData = this._friendList.searchResults.getResult(param2.id);
         if(_loc3_ == null)
         {
            Logger.log("No search result found with id: " + param2.id);
            return;
         }
         _friendList.messenger.startConversation(_loc3_.avatarId);
      }
      
      private function onSearchInput(param1:WindowEvent, param2:IWindowModel) : void
      {
         _friendList.view.showInfo(param1,"${friendlist.tip.searchstr}");
      }
      
      private function onSearchStrInput(param1:WindowKeyboardEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:String = null;
         var _loc5_:IWindowModel = IWindowModel(param1.target);
         Logger.log("Test key event " + param1 + ", " + param1.type + " " + _loc5_.name);
         if(param1.charCode == 13)
         {
            searchAvatar();
         }
         else
         {
            _loc2_ = 25;
            _loc4_ = _searchStr.text;
            if(_loc4_.length > _loc2_)
            {
               _searchStr.text = _loc4_.substring(0,_loc2_);
            }
         }
      }
      
      private function searchAvatar() : void
      {
         var _loc1_:String = _searchStr.text;
         Logger.log("Search avatar: " + _loc1_);
         if(_loc1_ == "")
         {
            Logger.log("No text...");
            return;
         }
         _friendList.send(new HabboSearchMessageComposer(_loc1_));
      }
   }
}

