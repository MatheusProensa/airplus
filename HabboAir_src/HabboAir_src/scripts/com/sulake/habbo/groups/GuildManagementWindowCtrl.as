package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.messages.incoming.users.GuildColorData;
   import com.sulake.habbo.communication.messages.incoming.users.GuildCreationData;
   import com.sulake.habbo.communication.messages.incoming.users.GuildEditData;
   import com.sulake.habbo.communication.messages.incoming.users.IGuildEditData;
   import com.sulake.habbo.communication.messages.incoming.users.RoomEntryData;
   import com.sulake.habbo.communication.messages.outgoing.users.CreateGuildMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildBadgeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildColorsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildIdentityMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UpdateGuildSettingsMessageComposer;
   import com.sulake.habbo.groups.badge.BadgeEditorCtrl;
   import com.sulake.habbo.groups.events.GuildSettingsChangedInManageEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.display.BitmapData;
   
   public class GuildManagementWindowCtrl implements IComponentInterfaceQueue
   {
      private static const VIEW_IDENTITY:int = 1;
      
      private static const VIEW_BADGE:int = 2;
      
      private static const VIEW_COLORS:int = 3;
      
      private static const VIEW_CONFIRM:int = 4;
      
      private static const VIEW_SETTINGS:int = 5;
      
      private static const UnknownConstFromGuildManagementWindowCtrl_Int_1:int = 43;
      
      private static const UnknownConstFromGuildManagementWindowCtrl_Int_2:int = 69;
      
      private static const EDIT_HEADER_TEXTS_OFFSET:int = -20;
      
      private static const CREATE_HEADER_BITMAP_OFFSET:int = 36;
      
      private static const STEP_TITLE_Y_OFFSET_ACTIVE:int = 5;
      
      private static const STEP_TITLE_Y_OFFSET_INACTIVE:int = 9;
      
      private static const STEP_TITLE_CREDIT_Y_OFFSET_ACTIVE:int = 6;
      
      private static const STEP_TITLE_CREDIT_Y_OFFSET_INACTIVE:int = 10;
      
      private static const MAX_DESCRIPTION_LENGTH:int = 255;
      
      private static const MAX_NAME_LENGTH:int = 30;
      
      private var UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1:HabboGroupsManager;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1:BadgeEditorCtrl;
      
      private var UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1:ColorGridCtrl;
      
      private var UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2:ColorGridCtrl;
      
      private var UnknownVarFromGuildManagementWindowCtrl_GuildSettingsCtrl_1:GuildSettingsCtrl;
      
      private var UnknownVarFromGuildManagementWindowCtrl_Boolean_1:Boolean = false;
      
      private var UnknownVarFromGuildManagementWindowCtrl_Int_1:int = 0;
      
      private var _data:IGuildEditData;
      
      private var UnknownVarFromGuildManagementWindowCtrl_Int_2:int = 1;
      
      public function GuildManagementWindowCtrl(param1:HabboGroupsManager)
      {
         super();
         UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1 = param1;
         UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1 = new BadgeEditorCtrl(UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1);
         UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1 = new ColorGridCtrl(UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1,onPrimaryColorSelected);
         UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2 = new ColorGridCtrl(UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1,onSecondaryColorSelected);
         UnknownVarFromGuildManagementWindowCtrl_GuildSettingsCtrl_1 = new GuildSettingsCtrl();
      }
      
      public function dispose() : void
      {
         UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1)
         {
            UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.dispose();
            UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1 = null;
         }
         if(UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1)
         {
            UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.dispose();
            UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1 = null;
         }
         if(UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2)
         {
            UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.dispose();
            UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1 == null;
      }
      
      private function prepare() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = IFrameController(UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.getXmlWindow("group_management_window"));
         _window.findChildByTag("close").procedure = onCloseWindow;
         _window.center();
         _window.findChildByName("create_room_link_region").procedure = onCreateRoomLink;
         _window.findChildByName("cancel_link_region").procedure = onCancelLink;
         _window.findChildByName("next_step_button").procedure = onNextStep;
         _window.findChildByName("previous_step_link_region").procedure = onPreviousStep;
         _window.findChildByName("buy_button").procedure = onBuy;
         _window.findChildByName("vip_required_region").procedure = onGetVip;
         _window.addEventListener("WE_DEACTIVATED",onWindowUnActivated);
         _window.findChildByName("edit_tab_1").procedure = onTab;
         _window.findChildByName("edit_tab_2").procedure = onTab;
         _window.findChildByName("edit_tab_3").procedure = onTab;
         _window.findChildByName("edit_tab_5").procedure = onTab;
         _window.findChildByName("reset_badge").procedure = onBadgeReset;
         _window.findChildByName("reset_colors").procedure = onColorReset;
         _window.findChildByName("step_1_members_region").procedure = onMembersClick;
         UnknownVarFromGuildManagementWindowCtrl_GuildSettingsCtrl_1.prepare(_window);
      }
      
      public function onFlatCreated(param1:int, param2:String) : void
      {
         if(_window != null && Boolean(_window.visible) && _data != null && !_data.exists)
         {
            _data.ownedRooms.splice(0,0,new RoomEntryData(param1,param2,false));
            prepareRoomSelection();
            this.getBaseDropMenu().selection = 0;
         }
      }
      
      public function onSubscriptionChange() : void
      {
         if(_window != null && Boolean(_window.visible) && _data != null && !_data.exists && UnknownVarFromGuildManagementWindowCtrl_Int_2 == 4)
         {
            refresh();
         }
      }
      
      public function refresh() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IWindowModel = null;
         prepare();
         var _loc3_:Boolean = !_data.exists || _data.isOwner;
         _window.findChildByName("edit_tab_1").visible = _loc3_;
         _window.findChildByName("edit_tab_2").visible = _loc3_;
         _window.findChildByName("edit_tab_3").visible = _loc3_;
         _window.findChildByName("edit_tab_5").visible = _loc3_;
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            getStepContainer(_loc2_).visible = UnknownVarFromGuildManagementWindowCtrl_Int_2 == _loc2_;
            _loc1_ = _window.findChildByName("header_pic_bitmap_step_" + _loc2_);
            _loc1_.y = _data.exists ? 0 : 36;
            _loc1_.visible = UnknownVarFromGuildManagementWindowCtrl_Int_2 == _loc2_;
            _loc2_++;
         }
         _window.findChildByName("header_caption_txt").caption = getStepCaption();
         _window.findChildByName("header_desc_txt").caption = getStepDesc();
         _window.findChildByName("header_pic_bitmap");
         _window.findChildByName("header_caption_txt").y = 43 + getHeaderTextOffset();
         _window.findChildByName("header_desc_txt").y = 69 + getHeaderTextOffset();
         _window.findChildByName("edit_guild_tab_context").visible = _data.exists;
         _window.findChildByName("footer_cont").visible = !_data.exists;
         _window.findChildByName("reset_badge").visible = false;
         _window.findChildByName("reset_colors").visible = false;
         if(UnknownVarFromGuildManagementWindowCtrl_Int_2 == 2)
         {
            if(!_data.exists)
            {
               UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.trackGoogle("groupPurchase","step2_badge");
            }
            if(!UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.isIntialized)
            {
               UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.createWindow(getStepContainer(2),_data.badgeSettings);
               UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.resetLayerOptions(_data.badgeSettings);
            }
            _window.findChildByName("reset_badge").visible = _data.exists;
         }
         if(UnknownVarFromGuildManagementWindowCtrl_Int_2 == 3)
         {
            if(!_data.exists)
            {
               UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.trackGoogle("groupPurchase","step3_colors");
            }
            if(!UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.isInitialized)
            {
               UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.createAndAttach(getStepContainer(3),"guild_primary_color_selector",UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.guildEditorData.guildPrimaryColors);
               if(_data.exists)
               {
                  UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.setSelectedColorById(_data.primaryColorId);
               }
               else
               {
                  UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.setSelectedColorById(UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.guildEditorData.findMatchingPrimaryColorId(UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.primaryColorIndex));
               }
            }
            if(!UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.isInitialized)
            {
               UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.createAndAttach(getStepContainer(3),"guild_secondary_color_selector",UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.guildEditorData.guildSecondaryColors);
               if(_data.exists)
               {
                  UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.setSelectedColorById(_data.secondaryColorId);
               }
               else
               {
                  UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.setSelectedColorById(UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.guildEditorData.findMatchingSecondaryColorId(UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.secondaryColorIndex));
               }
            }
            _window.findChildByName("reset_colors").visible = _data.exists;
         }
         if(UnknownVarFromGuildManagementWindowCtrl_Int_2 == 5)
         {
            if(!UnknownVarFromGuildManagementWindowCtrl_GuildSettingsCtrl_1.isInitialized)
            {
               UnknownVarFromGuildManagementWindowCtrl_GuildSettingsCtrl_1.refresh(_data);
            }
         }
         if(UnknownVarFromGuildManagementWindowCtrl_Int_2 == 4)
         {
            if(!_data.exists)
            {
               UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.trackGoogle("groupPurchase","step4_confirm");
            }
            updateConfirmPreview();
         }
         if(UnknownVarFromGuildManagementWindowCtrl_Int_2 == 1)
         {
            if(!_data.exists)
            {
               UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.trackGoogle("groupPurchase","step1_identity");
            }
            else
            {
               UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.windowManager.registerLocalizationParameter("group.membercount","totalMembers","" + _data.membershipCount);
               _window.findChildByName("step_1_members_txt").caption = UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.localization.getLocalization("group.membercount");
            }
            _window.findChildByName("base_label").visible = !_data.exists;
            _window.findChildByName("base_dropmenu").visible = !_data.exists;
            _window.findChildByName("base_warning").visible = !_data.exists;
            _window.findChildByName("create_room_link_region").visible = !_data.exists;
            _window.findChildByName("step_1_members_region").visible = data.exists;
         }
         refreshCreateHeader();
      }
      
      private function updateConfirmPreview() : void
      {
         var _loc1_:BitmapData = null;
         var _loc5_:IBitmapWrapperController = null;
         var _loc2_:GuildColorData = null;
         var _loc4_:IWindowModel = null;
         var _loc6_:GuildColorData = null;
         var _loc3_:IWindowModel = null;
         if(UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.guildEditorData == null || _window == null)
         {
            return;
         }
         if(UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.isIntialized)
         {
            _loc1_ = UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.getBadgeBitmap();
            _loc5_ = _window.findChildByName("badge_preview_image") as IBitmapWrapperController;
            if(_loc1_ != null && _loc5_ != null)
            {
               _loc5_.bitmap = _loc1_;
            }
         }
         if(UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.isInitialized)
         {
            _loc2_ = UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.getSelectedColorData();
            _loc4_ = _window.findChildByName("badge_preview_primary_color_top");
            if(_loc2_ != null && _loc4_ != null)
            {
               _loc4_.color = _loc2_.color;
            }
         }
         if(UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.isInitialized)
         {
            _loc6_ = UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.getSelectedColorData();
            _loc3_ = _window.findChildByName("badge_preview_secondary_color_top");
            if(_loc6_ != null && _loc3_ != null)
            {
               _loc3_.color = _loc6_.color;
            }
         }
         if(UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.hasVip)
         {
            _window.findChildByName("buy_button").enable();
            _window.findChildByName("buy_border").color = 16761600;
         }
         else
         {
            _window.findChildByName("buy_border").color = 11184810;
            _window.findChildByName("buy_button").disable();
         }
         _window.findChildByName("vip_required_border").visible = !UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.hasVip;
         _window.findChildByName("confirmation_caption").caption = ITextWindow(_window.findChildByName("name_txt")).text;
      }
      
      private function getHeaderTextOffset() : int
      {
         return _data.exists ? -20 : 0;
      }
      
      private function refreshCreateHeader() : void
      {
         var _loc1_:int = 0;
         _window.findChildByName("steps_header_cont").visible = !_data.exists;
         if(_data.exists)
         {
            return;
         }
         _window.findChildByName("next_step_button").visible = hasNextStep();
         _window.findChildByName("previous_step_link_region").visible = hasPreviousStep();
         _window.findChildByName("cancel_link_region").visible = !hasPreviousStep();
         _window.findChildByName("buy_border").visible = !hasNextStep();
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            getStepHeader(_loc1_,false).visible = _loc1_ != UnknownVarFromGuildManagementWindowCtrl_Int_2;
            getStepHeader(_loc1_,true).visible = _loc1_ == UnknownVarFromGuildManagementWindowCtrl_Int_2;
            _window.findChildByName("step_title_" + _loc1_).y = _loc1_ == UnknownVarFromGuildManagementWindowCtrl_Int_2 ? 5 : 9;
            _loc1_++;
         }
         _window.findChildByName("gcreate_icon_credit").y = UnknownVarFromGuildManagementWindowCtrl_Int_2 == 4 ? 6 : 10;
      }
      
      private function getStepHeader(param1:int, param2:Boolean) : IWindowModel
      {
         return _window.findChildByName("gcreate_" + param1 + "_" + (param2 ? "1" : "0"));
      }
      
      private function getStepContainer(param1:int) : IWindowController_1
      {
         return IWindowController_1(_window.findChildByName("step_cont_" + param1));
      }
      
      private function getStepCaption() : String
      {
         var _loc1_:String = (_data.exists ? "group.edit.tabcaption." : "group.create.stepcaption.") + UnknownVarFromGuildManagementWindowCtrl_Int_2;
         return UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.localization.getLocalization(_loc1_,_loc1_);
      }
      
      private function getStepDesc() : String
      {
         var _loc1_:String = (_data.exists ? "group.edit.tabdesc." : "group.create.stepdesc.") + UnknownVarFromGuildManagementWindowCtrl_Int_2;
         return UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.localization.getLocalization(_loc1_,_loc1_);
      }
      
      public function onGuildCreationInfo(param1:GuildCreationData) : void
      {
         _data = param1;
         UnknownVarFromGuildManagementWindowCtrl_Int_2 = 1;
         UnknownVarFromGuildManagementWindowCtrl_Int_1 = 0;
         refresh();
         refreshBadgeImage();
         setupInputs();
         UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.localization.registerParameter("group.create.confirm.buyinfo","amount","" + param1.costInCredits);
         _window.visible = true;
         _window.activate();
      }
      
      public function onGuildEditInfo(param1:GuildEditData) : void
      {
         _data = param1;
         UnknownVarFromGuildManagementWindowCtrl_Int_2 = 1;
         UnknownVarFromGuildManagementWindowCtrl_Int_1 = 0;
         refresh();
         refreshBadgeImage();
         setupInputs();
         var _loc2_:ITabContextWindow = ITabContextWindow(_window.findChildByName("edit_guild_tab_context"));
         var _loc3_:ISelectableWindow = ISelectableWindow(_window.findChildByName("edit_tab_" + UnknownVarFromGuildManagementWindowCtrl_Int_2));
         _loc2_.selector.setSelected(_loc3_);
         _window.visible = true;
         _window.activate();
      }
      
      private function setupInputs() : void
      {
         ITextWindow(_window.findChildByName("name_txt")).text = _data.groupName;
         ITextWindow(_window.findChildByName("desc_txt")).text = _data.groupDesc;
         prepareRoomSelection();
         UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.resetLayerOptions(_data.badgeSettings);
         UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.setSelectedColorById(_data.primaryColorId);
         UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.setSelectedColorById(_data.secondaryColorId);
         UnknownVarFromGuildManagementWindowCtrl_GuildSettingsCtrl_1.refresh(_data);
      }
      
      private function onTab(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WE_SELECT" || param2.id == UnknownVarFromGuildManagementWindowCtrl_Int_2)
         {
            return;
         }
         if(!validateView())
         {
            param1.preventDefault();
            return;
         }
         saveView();
         UnknownVarFromGuildManagementWindowCtrl_Int_2 = param2.id;
         refresh();
      }
      
      private function onColorReset(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.isInitialized)
            {
               UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.setSelectedColorById(_data.primaryColorId);
            }
            if(UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.isInitialized)
            {
               UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.setSelectedColorById(_data.secondaryColorId);
            }
         }
      }
      
      private function onBadgeReset(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK" && UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.isIntialized)
         {
            UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.resetLayerOptions(_data.badgeSettings);
         }
      }
      
      private function onMembersClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK" && _data.exists && UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.guildMembersWindowCtrl != null)
         {
            UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.trackGoogle("groupManagement","groupMembers");
            UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.guildMembersWindowCtrl.onMembersClick(_data.groupId,0);
         }
      }
      
      private function onCancelLink(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         close();
      }
      
      private function onCreateRoomLink(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.navigator.startRoomCreation();
      }
      
      private function onNextStep(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!validateView())
         {
            return;
         }
         UnknownVarFromGuildManagementWindowCtrl_Int_2 = limitStep(UnknownVarFromGuildManagementWindowCtrl_Int_2 + 1);
         refresh();
      }
      
      private function onPreviousStep(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!validateView())
         {
            return;
         }
         UnknownVarFromGuildManagementWindowCtrl_Int_2 = limitStep(UnknownVarFromGuildManagementWindowCtrl_Int_2 - 1);
         refresh();
      }
      
      private function onBuy(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!_data.exists)
         {
            UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.trackGoogle("groupPurchase","buyGroup");
         }
         sendCreateGuildMessage();
      }
      
      private function onGetVip(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(!_data.exists)
         {
            UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.trackGoogle("groupPurchase","buyVip");
         }
         UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.openVipPurchase("GuildManagementWindowCtrl");
      }
      
      private function showAlert(param1:String, param2:String) : void
      {
         if(!UnknownVarFromGuildManagementWindowCtrl_Boolean_1)
         {
            UnknownVarFromGuildManagementWindowCtrl_Boolean_1 = true;
            UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.windowManager.alert(param1,param2,0,onAlertClose);
         }
      }
      
      private function onAlertClose(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
         UnknownVarFromGuildManagementWindowCtrl_Boolean_1 = false;
      }
      
      private function validateView() : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:RoomEntryData = null;
         var _loc4_:String = null;
         var _loc1_:Array = null;
         switch(UnknownVarFromGuildManagementWindowCtrl_Int_2 - 1)
         {
            case 0:
               _loc2_ = ITextFieldWindow(_window.findChildByName("name_txt")).text;
               if(!_data.exists)
               {
                  _loc3_ = resolveBaseRoom();
                  if(_loc2_ == null || _loc2_.length == 0 || _loc3_ == null || _loc3_.roomId == 0)
                  {
                     showAlert("${group.edit.error.title}","${group.edit.error.no.name.or.room.selected}");
                     return false;
                  }
                  if(_loc3_.hasControllers && UnknownVarFromGuildManagementWindowCtrl_Int_1 != _loc3_.roomId)
                  {
                     UnknownVarFromGuildManagementWindowCtrl_Int_1 = _loc3_.roomId;
                     showAlert("${group.edit.error.warning}","${group.edit.error.controllers}");
                     return false;
                  }
               }
               if(_loc2_.length > 30)
               {
                  showAlert("${group.edit.error.title}","${group.edit.error.name.length}");
                  return false;
               }
               _loc4_ = ITextFieldWindow(_window.findChildByName("desc_txt")).text;
               if(_loc4_ != null && _loc4_.length >= 255)
               {
                  showAlert("${group.edit.error.title}","${group.edit.error.desc.length}");
                  return false;
               }
               return true;
               break;
            case 1:
               _loc1_ = UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.isIntialized ? UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.getBadgeSettings() : _data.badgeSettings;
               UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.onViewChange();
               return true;
            case 2:
               if(UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.getSelectedColorData() == null || UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.getSelectedColorData() == null)
               {
                  showAlert("${group.edit.error.title}","${group.edit.error.no.color.selected}");
                  return false;
               }
               return true;
               break;
            default:
               return true;
         }
      }
      
      private function saveView() : void
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         switch(UnknownVarFromGuildManagementWindowCtrl_Int_2 - 1)
         {
            case 0:
               _loc3_ = ITextFieldWindow(_window.findChildByName("name_txt")).text;
               _loc5_ = ITextFieldWindow(_window.findChildByName("desc_txt")).text;
               if(_data.isOwner)
               {
                  UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.send(new UpdateGuildIdentityMessageComposer(_data.groupId,_loc3_,_loc5_));
               }
               UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.events.dispatchEvent(new GuildSettingsChangedInManageEvent("GSCIME_GUILD_VISUAL_SETTINGS_CHANGED",_data.groupId));
               return;
            case 1:
               _loc1_ = UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.isIntialized ? UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.getBadgeSettings() : _data.badgeSettings;
               if(_data.isOwner)
               {
                  UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.send(new UpdateGuildBadgeMessageComposer(_data.groupId,_loc1_));
               }
               UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.events.dispatchEvent(new GuildSettingsChangedInManageEvent("GSCIME_GUILD_VISUAL_SETTINGS_CHANGED",_data.groupId));
               break;
            case 2:
               _loc2_ = UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.isInitialized ? UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.getSelectedColorId() : _data.primaryColorId;
               _loc4_ = UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.isInitialized ? UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.getSelectedColorId() : _data.secondaryColorId;
               if(_data.isOwner)
               {
                  UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.send(new UpdateGuildColorsMessageComposer(_data.groupId,_loc2_,_loc4_));
               }
               UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.events.dispatchEvent(new GuildSettingsChangedInManageEvent("GSCIME_GUILD_VISUAL_SETTINGS_CHANGED",_data.groupId));
               break;
            case 4:
               if(_data.isOwner)
               {
                  UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.send(new UpdateGuildSettingsMessageComposer(_data.groupId,UnknownVarFromGuildManagementWindowCtrl_GuildSettingsCtrl_1.guildType,UnknownVarFromGuildManagementWindowCtrl_GuildSettingsCtrl_1.rightsLevel));
               }
               UnknownVarFromGuildManagementWindowCtrl_GuildSettingsCtrl_1.resetModified();
         }
      }
      
      private function sendCreateGuildMessage() : void
      {
         var _loc3_:String = ITextFieldWindow(_window.findChildByName("name_txt")).text;
         var _loc5_:String = ITextFieldWindow(_window.findChildByName("desc_txt")).text;
         var _loc6_:RoomEntryData = resolveBaseRoom();
         var _loc1_:Array = UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.isIntialized ? UnknownVarFromGuildManagementWindowCtrl_BadgeEditorCtrl_1.getBadgeSettings() : _data.badgeSettings;
         var _loc2_:int = UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.isInitialized ? UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_1.getSelectedColorId() : _data.primaryColorId;
         var _loc4_:int = UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.isInitialized ? UnknownVarFromGuildManagementWindowCtrl_ColorGridCtrl_2.getSelectedColorId() : _data.secondaryColorId;
         UnknownVarFromGuildManagementWindowCtrl_Int_1 = 0;
         UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.send(new CreateGuildMessageComposer(_loc3_,_loc5_,_loc6_.roomId,_loc2_,_loc4_,_loc1_));
      }
      
      private function hasPreviousStep() : Boolean
      {
         return UnknownVarFromGuildManagementWindowCtrl_Int_2 != limitStep(UnknownVarFromGuildManagementWindowCtrl_Int_2 - 1);
      }
      
      private function hasNextStep() : Boolean
      {
         return UnknownVarFromGuildManagementWindowCtrl_Int_2 != limitStep(UnknownVarFromGuildManagementWindowCtrl_Int_2 + 1);
      }
      
      private function limitStep(param1:int) : int
      {
         return Math.max(1,Math.min(param1,4));
      }
      
      private function getBaseDropMenu() : IDropBaseController_1
      {
         return IDropBaseController_1(_window.findChildByName("base_dropmenu"));
      }
      
      private function prepareRoomSelection() : void
      {
         var _loc2_:int = 0;
         var _loc4_:RoomEntryData = null;
         var _loc1_:IDropBaseController_1 = getBaseDropMenu();
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         _loc3_.push(UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.localization.getLocalization("group.edit.base.select.room","group.edit.base.select.room"));
         _loc2_ = 0;
         while(_loc2_ < _data.ownedRooms.length)
         {
            _loc4_ = _data.ownedRooms[_loc2_];
            _loc3_.push(_loc4_.roomName);
            if(_loc4_.roomId == _data.baseRoomId)
            {
               _loc5_ = _loc2_ + 1;
            }
            _loc2_++;
         }
         _loc1_.populate(_loc3_);
         if(_loc3_.length > 0)
         {
            _loc1_.selection = _loc5_;
         }
      }
      
      private function resolveBaseRoom() : RoomEntryData
      {
         var _loc1_:IDropBaseController_1 = IDropBaseController_1(_window.findChildByName("base_dropmenu"));
         var _loc2_:int = _loc1_.selection - 1;
         if(_loc2_ >= 0 && _loc2_ < _data.ownedRooms.length && _data.ownedRooms[_loc2_] != null)
         {
            return RoomEntryData(_data.ownedRooms[_loc2_]);
         }
         return null;
      }
      
      private function onCloseWindow(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_data.exists)
         {
            if(!validateView())
            {
               return;
            }
            saveView();
         }
         close();
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      public function onPrimaryColorSelected(param1:ColorGridCtrl) : void
      {
         var _loc3_:GuildColorData = null;
         var _loc2_:IWindowModel = _window.findChildByName("guild_color_primary_color_top");
         if(_loc2_ != null && UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.guildEditorData != null && param1.selectedColorIndex >= 0 && param1.selectedColorIndex <= UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.guildEditorData.guildPrimaryColors.length)
         {
            _loc3_ = UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.guildEditorData.guildPrimaryColors[param1.selectedColorIndex];
            _loc2_.color = _loc3_.color;
         }
      }
      
      public function onSecondaryColorSelected(param1:ColorGridCtrl) : void
      {
         var _loc3_:GuildColorData = null;
         var _loc2_:IWindowModel = _window.findChildByName("guild_color_secondary_color_top");
         if(UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.guildEditorData != null && param1.selectedColorIndex >= 0 && param1.selectedColorIndex <= UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.guildEditorData.guildSecondaryColors.length)
         {
            _loc3_ = UnknownVarFromGuildManagementWindowCtrl_HabboGroupsManager_1.guildEditorData.guildSecondaryColors[param1.selectedColorIndex];
            _loc2_.color = _loc3_.color;
         }
      }
      
      public function get data() : IGuildEditData
      {
         return _data;
      }
      
      private function refreshBadgeImage() : void
      {
         var _loc2_:IWindowModel = _window.findChildByName("step_1_badge");
         var _loc1_:IBadgeImageWidget = IWidgetWindowController(_window.findChildByName("group_logo")).widget as IBadgeImageWidget;
         if(_loc1_ == null || _loc2_ == null)
         {
            return;
         }
         if(!_data.exists)
         {
            _loc2_.visible = false;
            _loc2_.invalidate();
         }
         else
         {
            _loc1_.badgeId = _data.badgeCode;
            _loc1_.groupId = _data.groupId;
            _loc2_.visible = true;
            _loc2_.invalidate();
         }
      }
      
      private function onWindowUnActivated(param1:WindowEvent) : void
      {
         if(_data != null && _data.exists && _window != null && Boolean(_window.visible))
         {
            saveView();
         }
      }
   }
}

