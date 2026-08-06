package com.sulake.habbo.window
{
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.advertisement.InterstitialMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.avatar.OutfitData;
   import com.sulake.habbo.communication.messages.outgoing.advertisement.GetInterstitialMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.RequestABadgeComposer;
   import com.sulake.habbo.communication.messages.outgoing.inventory.trading.CloseTradingComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.AcceptQuestMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.register.UpdateFigureDataMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.ClickFurniMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.MoveAvatarMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.PlaceObjectMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.WiredClickUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredSetObjectVariableValueMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GiveStarGemToUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.RespectUserMessageComposer;
   import com.sulake.habbo.room.object.data.EmptyStuffData;
   import com.sulake.habbo.room.object.data.MapStuffData;
   import com.sulake.habbo.roomevents.wired_setup.RoomObjectHighLighter;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.utils.Base64;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.room.utils.RoomRotatingEffect;
   import com.sulake.room.utils.Vector3d;
   import flash.desktop.NativeApplication;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.net.FileFilter;
   import flash.net.FileReference;
   import flash.net.SharedObject;
   import flash.ui.Keyboard;
   import flash.utils.*;
   
   public class LilithCustoms implements ILinkEventTracker
   {
      public var IsNavigatorFilterEnabled:Boolean;
      
      public var WardrobePagesDictionary:Dictionary;
      
      public var CurrentWardrobePage:int = 0;
      
      public var WardrobePagesCount:int = 0;
      
      public var LatestClickedFurnitureID:*;
      
      public var DevWarUserFigure:*;
      
      public var DevWarUserSex:*;
      
      public var DevWarIsOpen:* = false;
      
      public var DevWarAdvicePending:* = true;
      
      public var ShowAllChatBubbles:Boolean;
      
      public var CustomChatSize:int;
      
      public var IsChatEnabled:Boolean;
      
      public var InfoStandDisabled:*;
      
      public var ShowObjectsIds:*;
      
      public var ChatTypingEnabled:*;
      
      public var ShowCriticalErrors:* = false;
      
      public var ShowQuestsIds:* = false;
      
      public var CurrentRoomPlaneParser:*;
      
      public var IsWCUBlockEnabled:Boolean = false;
      
      public var FriendOnlineNotification:int;
      
      public var RoomObjectMouseKeyboardShortcutsEnabled:* = true;
      
      public var ShiftWalkBlockEnabled:Boolean = false;

      public var CtrlUseFurniOnSingleClickEnabled:Boolean = false;

      public var MandiocaFritaAtiva:Boolean = false;
      
      private var FriendGiveGemID:int;
      
      private var FriendGiveGemAmount:int;
      
      public var HideIgnoredBubbleEnabled:Boolean = false;
      
      public var SeasonalColorsEnabled:Boolean = true;
      
      public var MutePetsEnabled:Boolean = false;
      
      public var MuteBotsEnabled:Boolean = false;
      
      public var MuteCommandsEnabled:Boolean = false;
      
      public var HotKeyPressMode:String = "up";
      
      public var DesiredRoomFractionalSize:Number;
      
      public var ModCautionAlertsEnabled:Boolean = true;
      
      public var IsPlayingEnabled:Boolean = false;
      
      public var IsTurnBlockEnabled:Boolean = false;
      
      internal var WindowManager:*;
      
      internal var SavedLooksDictionary:Dictionary;
      
      internal var HotKeysDictionary:Dictionary;
      
      internal var HotKeyPendingToSet:Boolean = false;
      
      internal var HotKeyPendingValue:String;
      
      internal var AllowedCommands:Array;
      
      internal var AirPlusCommandsHabboPageBase64:String;
      
      internal var RoomBacklight:int;
      
      internal var RoomLight:int;
      
      internal var RoomLightTimer:Timer;
      
      internal var RoomBackgroundColors:Array;
      
      internal var RoomBackgroundColorTimer:Timer;
      
      internal var RoomEngineTimer:Timer;
      
      internal var DesiredFpsValue:int;

      internal var AnimationFpsUnlocked:*;
      
      internal var ObjectHighlighter:*;
      
      internal var ObjectHighlighterEnabled:* = false;
      
      internal var HighlightedObjectsIds:Array;
      
      internal var ObjectHighlighterIdsLimit:* = 1;
      
      internal var AutoClickSelectionRequested:* = false;
      
      internal var AutoClickCurrentObjectId:int = 0;
      
      internal var AutoClickObjectsIds:Array;
      
      internal var AutoClickTimer:Timer;

      internal var TotemTimer:Timer;

      internal var TotemFurni:Array;

      public var PetTalkActive:Boolean = false;

      internal var PetTalkTimer:Timer;

      internal var PetTalkMessages:Array;

      internal var MilkBowlQueue:Array;

      internal var MilkBowlTimer:Timer;

      internal var PetChatQueue:Array;

      internal var PetChatTimer:Timer;

      public var BallTrackActive:Boolean = false;

      internal var BallTrackFurniId:int = 0;

      internal var BallTrackTimer:Timer;

      internal var BallTrackFilters:Array;

      public var FurniHideActive:Boolean = false;

      internal var HiddenFurniData:Array;

      internal var EssentialFballTypes:Array;

      internal var BallTrackMarkerIds:Array;

      internal var BallTrackMarkersSpawned:Boolean = false;

      internal var BallTrackLastTileX:int = -9999;

      internal var BallTrackLastTileY:int = -9999;

      internal var DevWarTimer:Timer;
      
      internal var TitleBarColor:uint;
      
      internal var BottomBarColor:uint;
      
      internal var WindowBlend:String;
      
      internal var BottomBarBlend:String;
      
      internal var BottomBarAltStyleEnabled:*;
      
      internal var SeasonalColorsActive:* = false;
      
      internal var UserCustomFx:int;
      
      internal var UserCustomFxTimer:Timer;
      
      internal var AntiAfkModeActivated:*;
      
      internal var AntiAfkModeTimer:Timer;
      
      internal var PingResponseMessageEvent:*;
      
      internal var PingRequestTimestamp:int;
      
      internal var PingSay:* = false;
      
      internal var PingBeforeText:String;
      
      internal var PingAfterText:String;
      
      internal var PingBubble:String;
      
      internal var AdBlockActivated:*;
      
      internal var SpoofBubbles:String;
      
      internal var CommandInputColorHintActivated:*;
      
      internal var ChatTextColorEnabled:*;
      
      internal var FurniDoubleClickEnabled:*;
      
      internal var ZoomGesturesEnabled:*;
      
      internal var RoomDisplayLowFpsBoost:String;
      
      internal var FloodTimer:Timer;
      
      internal var FloodText:String;
      
      internal var WalkEnabled:Boolean = true;
      
      internal var TradeEnabled:Boolean = true;
      
      internal var TradeBlockTimer:Timer;
      
      internal var ChatAlarmText:String = "";
      
      internal var SingleTimeAlertDisplayed:Boolean = false;
      
      internal var FriendHighlightEnabled:*;
      
      internal var UseFurniOnSingleClickEnabled:Boolean = false;
      
      internal var LinkPortRequested:* = false;
      
      private var LastAddedObjectId:int;
      
      private var ChatTextColors:Array;
      
      private var ChatTextSpecialMods:Array;
      
      private var IsTradingOpen:Boolean;
      
      private var IsUserChooserOpen:Boolean = false;
      
      private var IsFurniChooserOpen:Boolean = false;
      
      private var keyCodeNames:* = null;
      
      private var FriendsOnlineNotificationTimer:Timer;
      
      private var PendingFriendsOnlineNotification:*;
      
      private var PendingFriendFace:* = null;
      
      private var FriendGhostFace:* = null;
      
      private var RoomCameraFollowDisablerTimer:Timer;
      
      private var SpawnHelperTimer:Timer;
      
      private var FakeFurniId:int = 0;
      
      private var RejectedPollsIds:Array;
      
      private var ActiveRoomCanvasReadyTimer:Timer;
      
      private var AirPlusSolImportFR:FileReference;
      
      public function LilithCustoms(WindowManager:*)
      {
         super();
         this.ResetVariablesValues();
         this.WindowManager = WindowManager;
         this.ChatTextColors = new Array("@red@","@cyan@","@blue@","@green@","@purple@");
         this.ChatTextSpecialMods = new Array("[b]","[/b]","[i]","[/i]","[u]","[/u]","[red]","[/red]","[blue]","[/blue]","[purple]","[/purple]","[green]","[/green]","[cyan]","[/cyan]");
         this.AllowedCommands = new Array(":)",":(",":o",":shake",":d",":kiss",":jump",":news",":mail",":kick",":shutup",":mute",":idle",":fps",":sign",":drop",":dropitem",":chooser",":furni",":pickall",":pickallbc",":resetscores",":ejectall",":ejectpets",":moonwalk",":habnam",":yyxxabxa",":mutepets",":mutebots",":mpgame",":ignore",":unignore",":floor",":bcfloor",":lang",":uc",":anew",":avisit",":aalert",":visit",":roomid",":zoom",":cam",":camera",":fs",":fullscreen",":screenshot",":iddqd",":hidemouse",":demonictriggers",":playing",":fx",":stand",":sit",":dance",":clone",":afk",":ping",":pingsay",":barcolor",":color",":showbubbles",":pingbubble",":pingubble",":pingbeforetext",":pingaftertext",":chatsize",":chatmute",":infostand",":showids",":resetvars",":autoclick",":devwar",":stopdevwar",":autoclickdelay",":lightsaber",":givegem",":linkevent",":calendar",":handitem",":habboway",":safetybook",":respect",":fpsunlock",":unlockfps",":bgcolor",":backlight",":roomlight",":adblock",":typing",":spoofbubbles"
         ,":spoofbubble",":rotate",":figure",":showquestsids",":acceptquest",":say",":shout",":whisper",":give",":pass",":hkset",":hkclear",":hkshow",":showhk",":f1",":f2",":f3",":f4",":f5",":f6",":f7",":f8",":f9",":f10",":f11",":f12",":commands",":cmdcolor",":chatcolor",":wf",":wired",":var",":variables",":inspect",":inspection",":about",":version",":nodc",":zoomgestures",":flood",":flooddelay",":floodelay",":showfps",":showstats",":abctest",":tradeblock",":walkblock",":chatalarm",":turnblock",":wcublock",":zoomf",":clickuser",":clickfurni",":usefurni",":movetofurni",":aprilfools",":playtest",":crash",":showerrors",":friendhl",":winblend",":barblend",":barstyle",":fon",":shift",":swb",":dc",":ctrl",":hideignoredbubble",":spawn",":laugh",":seasonal",":hkmode",":furnitech",":mutecmd",":clearchat",":clearhist",":caution",":hidefigures",":hidepoints",":linkport",":portlink",":savelook",":removelook",":clearlooks",":uselook",":showlooks",":showstats",":rescam",":totem",":solimp",":solexp",":navfilter",":vip",":mandiocafrita",":petfala",":caixapreta",":furniture");
         this.AirPlusCommandsHabboPageBase64 = "OmJhY2tsaWdodCBbMC0yNTVdIChzZXQgcm9vbSBiYWNrbGlnaHQgdmFsdWUgd2l0aCBmb3JjZWQgbW9kZSkKOnJvb21saWdodCBbMC0yNTVdIChzZXQgcm9vbSBsaWdodCB2YWx1ZSB3aXRoIGZvcmNlZCBtb2RlKQo6Ymdjb2xvciBbSHVlTnVtYmVyXSBbU2F0dXJhdGlvbk51bWJlcl0gW0xpZ2h0bmVzc051bWJlcl0gKGNoYW5nZSByb29tIGJhY2tncm91bmQgY29sb3Igd2l0aCBmb3JjZWQgbW9kZSkKOmZwcyBOdW1iZXIgKGNoYW5nZSBjdXJyZW50IGZwcyB2YWx1ZSB3aXRoIGZvcmNlZCBtb2RlKQo6dW5sb2NrZnBzICh1bmxvY2svbG9jayBhbmltYXRpb25zIGZwcyB3aXRoIGZvcmNlZCBtb2RlKQo6cmVzcGVjdCAoZ2l2ZSByZXNwZWN0cyB0byBjbGlja2VkIHVzZXIpIChVU0UgQVQgT1dOIFJJU0spCjpzYWZldHlib29rIChzaG93IGhvdGVsIHNhZmV0eSBib29rKQo6aGFiYm93YXkgKHNob3cgaGFiYm8gd2F5IGluZm8pCjpoYW5kaXRlbSBbSXRlbUlkXSAoY2hhbmdlIGN1cnJlbnQgdXNlciBoYW5kaXRlbSkgKElOIFNFUlZFUi1TSURFIENBU0VTIFVTRSBBVCBPV04gUklTSykKOmNhbGVuZGFyIChvcGVuIGNhbGVuZGFyKSAoVVNFIEFUIE9XTiBSSVNLKQo6bGlua2V2ZW50IFtMaW5rXSAob3BlbiBhIGxpbmtldmVudCkgKElOIFNFUlZFUi1TSURFIENBU0VTIFVTRSBBVCBPV04gUklTSykKOmdpdmVnZW0gW0Ftb3VudF0gKGdpdmUgZ2VtcyB0byBjbGlja2VkIHVzZXIpIChVU0UgQVQgT1dOIFJJU0spCjpsaWdodHNhYmVyICh0b2dnbGUgbGlnaHRzYWJlciBmeCkKOmF1dG9jbGljayAodG9nZ2xlIGF1dG9jbGljayBtb2RlKQo6YXV0b2NsaWNrZGVsYXkgKGNoYW5nZSBhdXRvY2xpY2sgZGVsYXkpCjpkZXZ3YXIgKHRlc3QgYWxsIGF2YWlsYWJsZSBjbG90aGVzIHdpdGggZm9yY2VkIG1vZGUpIChvcHRpb25hbDogZmlndXJlIGNhbiBiZSBsb2FkZWQgZnJvbSBjbGlja2VkIHVzZXIpIChJTiBTRVJWRVItU0lERSBDQVNFUyBVU0UgQVQgT1dOIFJJU0spCjpzdG9wZGV2d2FyIChzdG9wIGRldndhciBjb21tYW5kIGFuZCByZWNvdmVyIHlvdXIgcmVhbCBsb29rKQo6cmVzZXR2YXJzIChyZXNldCBzYXZlZCBjbGllbnQgdmFyaWFibGVzKQo6aW5mb3N0YW5kICh0b2dnbGUgZnVybmkvdXNlciBpbmZvc3RhbmQgdmlzaWJpbGl0eSkKOmNoYXRtdXRlIChtdXRlL3VubXV0ZSByb29tIGNoYXQgd2l0aCBmb3JjZWQgbW9kZSBhbmQgd2l0aG91dCBhZmZlY3RpbmcgY2hhdCBoaXN0b3J5KQo6Y2hhdHNpemUgWzEyLTQwXSAoY2hhbmdlIGNoYXQgZm9udCBzaXplIHdpdGggZm9yY2VkIG1vZGUpCjpzaG93YnViYmxlcyAoc2hvdyBhbGwgY2hhdCBidWJibGVzIHN0eWxlcykKOnNwb29mYnViYmxlcyBbb3B0aW9uYWw6b3duXSAoc3Bvb2YgY2hhdCBidWJibGVzIHRvIGN1cnJlbnQgc2VsZWN0ZWQgY2hhdCBidWJibGUgc3R5bGUpCjpzZWFzb25hbCAodG9nZ2xlIGNsaWVudCBzZWFzb25hbCBjb2xvcnMpCjpjb2xvciBbSGV4Q29sb3IvY2xhc3NpYy9waW5rXSAoY2hhbmdlIGNsaWVudCB0aXRsZSBiYXIgY29sb3IpCjpiYXJjb2xvciBbSGV4Q29sb3IvY2xhc3NpYy9waW5rXSAoY2hhbmdlIGNsaWVudCBib3R0b20gYmFyIGNvbG9yKQo6d2luYmxlbmQgWzAuMCB0byAxLjBdIChjaGFuZ2UgY2xpZW50IHdpbmRvdyBibGVuZCB2YWx1ZSkKOmJhcmJsZW5kIFswLjAgdG8gMS4wXSAoY2hhbmdlIGNsaWVudCBib3R0b20gYmFyIGJsZW5kIHZhbHVlKQo6YmFyc3R5bGUgKHRvZ2dsZSBjbGllbnQgYm90dG9tIGJhciBhbHRlcm5hdGl2ZSBzdHlsZSkKOnBsYXlpbmcgKHRvZ2dsZSBjbGljay10aHJvdWdoIHdpdGggZm9yY2VkIG1vZGUpCjpmeCBbRnhJZF0gKGNoYW5nZSBjdXJyZW50IHVzZXIgZnggd2l0aCBmb3JjZWQgbW9kZSkgKElOIFNFUlZFUi1TSURFIENBU0VTIFVTRSBBVCBPV04gUklTSykKOmRhbmNlIFswLTRdIChjaGFuZ2UgY3VycmVudCBkYW5jZSBzdHlsZSkKOmNsb25lIFtvcHRpb25hbDpTZXgoTSBvciBGKV0gKGNsb25lIGNsaWNrZWQgdXNlciBsb29rKQo6YWZrICh0b2dnbGUgYW50aSBhZmsgd2l0aCBmb3JjZWQgbW9kZSkKOnBpbmcgKGdldCBsYXRlc3QgcGluZyB2YWx1ZSkgKFVTRSBBVCBPV04gUklTSykKOnBpbmdzYXkgKHB1YmxpY2x5IHNheSBsYXRlc3QgcGluZyB2YWx1ZSkgKFVTRSBBVCBPV04gUklTSykKOnBpbmdiZWZvcmV0ZXh0IChjaGFuZ2UgdGV4dCBiZWZvcmUgcGluZyB2YWx1ZSkKOnBpbmdhZnRlcnRleHQgKGNoYW5nZSB0ZXh0IGFmdGVyIHBpbmcgdmFsdWUpCjpwaW5nYnViYmxlIFtvcHRpb25hbDphdXRvXSAoY2hhbmdlIHBpbmdzYXkgYnViYmxlIHRvIGN1cnJlbnQgc2VsZWN0ZWQgY2hhdCBidWJibGUgc3R5bGUpCjpzaG93aWRzICh0b2dnbGUgb2JqZWN0cyBpZHMgdmlld2VyKQo6dHlwaW5nICh0b2dnbGUgY2hhdCB0eXBpbmcgaW5kaWNhdG9yKSAoVVNFIEFUIE9XTiBSSVNLKQo6cm90YXRlICh0b2dnbGUgcm9vbSByb3RhdGUgZWZmZWN0KQo6YWRibG9jayAodG9nZ2xlIG1wdSBhZCBibG9ja2VyKSAoSU4gU0VSVkVSLVNJREUgQ0FTRVMgVVNFIEFUIE9XTiBSSVNLKQo6ZmlndXJlIFtGaWd1cmVDb2RlXSBbb3B0aW9uYWw6RmlndXJlU2V4KE0gb3IgRildIChjaGFuZ2UgYXZhdGFyIGZpZ3VyZSkKOnNob3dxdWVzdHNpZHMgKHRvZ2dsZSBxdWVzdHMgaWRzKQo6YWNjZXB0cXVlc3QgW1F1ZXN0SWRdIChtYW51YWxseSBhY2NlcHQgcXVlc3QgYnkgaWQpCjpzYXkgW1NvbWV0aGluZ10gKHNheSBzb21ldGhpbmcsIGV2ZW4gY29tbWFuZHMpCjpzaG91dCBbU29tZXRoaW5nXSAoc2hvdXQgc29tZXRoaW5nLCBldmVuIGNvbW1hbmRzKQo6d2hpc3BlciBbU29tZXRoaW5nXSAod2hpc3BlciBzb21ldGhpbmcgdG8gY2xpY2tlZCB1c2VyLCBldmVuIGNvbW1hbmRzKQo6Z2l2ZSBvciA6cGFzcyAoZ2l2ZSBoYW5kaXRlbSB0byBjbGlja2VkIHVzZXIvcGV0KSAoVVNFIEFUIE9XTiBSSVNLIE9OIFBFVFMpCjpoa3NldCBbb3B0aW9uYWw6Q2hhdElucHV0XSAoc2V0IGEgbmV3IGNoYXQgaW5wdXQgaG90a2V5KQo6aGttb2RlICh0b2dnbGUgaG90a2V5IHByZXNzIG1vZGUpCjpoa3Nob3cgKHNob3cgc2F2ZWQgaG90a2V5cykKOmhrY2xlYXIgKGNsZWFyIGNoYXQgaW5wdXQgaG90a2V5cykKOmYxIHRvIDpmMTIgW29wdGlvbmFsOkNoYXRJbnB1dF0gKHF1aWNrbHkgc2V0IG5ldyBjaGF0IGlucHV0IGhvdGtleSB3aXRoIGZ1bmN0aW9uIGtleXMpCjpjb21tYW5kcyAoc2hvdyBhaXJwbHVzIGNvbW1hbmRzIGxpc3QpCjpjbWRjb2xvciAodG9nZ2xlIGNvbW1hbmQgaW5wdXQgY29sb3IgaGludCArIHRhYiBhdXRvY29tcGxldGlvbikKOmNoYXRjb2xvciAodG9nZ2xlIHVzZXJzIGN1c3RvbSBjaGF0IHRleHQgY29sb3IpCjphYm91dCBvciA6dmVyc2lvbiAoc2hvdyBjbGllbnQgdmVyc2lvbiBpbmZvKQo6ZGMgKHRvZ2dsZSB1c2UgZnVybml0dXJlcyBvbiBzaW5nbGUgY2xpY2spCjpub2RjICh0b2dnbGUgZnVybml0dXJlIGRvdWJsZSBjbGljayBjYXBhYmlsaXR5KQo6em9vbWdlc3R1cmVzICh0b2dnbGUgem9vbSBnZXN0dXJlcyBjYXBhYmlsaXR5KQo6Zmxvb2QgW29wdGlvbmFsOkNoYXRJbnB1dF0gICh0b2dnbGUgY2hhdCBpbnB1dCBmbG9vZCkKOmZsb29kZGVsYXkgKGNoYW5nZSBjaGF0IGlucHV0IGZsb29kIGRlbGF5KQo6dHJhZGVibG9jayAodG9nZ2xlIHRyYWRlIGJsb2NrKQo6d2Fsa2Jsb2NrICh0b2dnbGUgd2FsayBibG9jaykKOmNoYXRhbGFybSBbVHJpZ2dlclRleHRdICh0b2dnbGUgY2hhdCBzb3VuZCBhbGFybSkKOnR1cm5ibG9jayAodG9nZ2xlIGF2YXRhciB0dXJuL2xvb2t0byBibG9jaykKOndjdWJsb2NrICh0b2dnbGUgd2lyZWRjbGlja3VzZXIgYmxvY2spCjp6b29tZiBbVmFsdWVdICh0b2dnbGUgZnJhY3Rpb25hbCByb29tIHpvb20gd2l0aCBmb3JjZWQgbW9kZSkKOmNsaWNrdXNlciBbVXNlclRlbXBJZC9MYXRlc3RDbGlja2VkVXNlcl0gKGNsaWNrIHRoZSBzZWxlY3RlZCB1c2VyKQo6Y2xpY2tmdXJuaSBbRnVybml0dXJlSWQvTGF0ZXN0Q2xpY2tlZEZ1cm5pdHVyZV0gKGNsaWNrIHRoZSBzZWxlY3RlZCBmdXJuaXR1cmUpCjp1c2VmdXJuaSBbRnVybml0dXJlSWQvTGF0ZXN0Q2xpY2tlZEZ1cm5pdHVyZV0gKHVzZSB0aGUgc2VsZWN0ZWQgZnVybml0dXJlKQo6bW92ZXRvZnVybmkgW0Z1cm5pdHVyZUlkL0xhdGVzdENsaWNrZWRGdXJuaXR1cmVdIChtb3ZlIHRvIHRoZSBzZWxlY3RlZCBmdXJuaXR1cmUpCjphcHJpbGZvb2xzIChyZXF1ZXN0IGFwcmlsIGZvb2xzIDIwMjUgYmFkZ2VzKSAoVVNFIEFUIE9XTiBSSVNLKQo6Y3Jhc2ggKGdlbmVyYXRlIGEgY3JpdGljYWwgZXJyb3IpCjpzaG93ZXJyb3JzIChzaG93L2hpZGUgY3JpdGljYWwgY2xpZW50IGVycm9ycykKOmZyaWVuZGhsICh0b2dnbGUgZnJpZW5kIG5hbWUgZW50cmFuY2UgaGlnaGxpZ2h0KQo6Zm9uIFswLTJdICgwPWRpc2FibGVkLzE9ZW5hYmxlZCBmb3IgYWxsLzI9ZW5hYmxlZCBmb3IgcmVsYXRpb25zaGlwcykgKHNob3cgYSBub3RpZmljYXRpb24gd2hlbiBhIGZyaWVuZCBnb2VzIG9ubGluZSkKOnNoaWZ0ICh0b2dnbGUgc2hpZnQga2V5IHRvIHdhbGsgYmxvY2spCjpjdHJsICh0b2dnbGUgY3RybCBrZXkgdG8gdXNlIGZ1cm5pdHVyZXMgb24gc2luZ2xlIGNsaWNrKQo6aGlkZWlnbm9yZWRidWJibGUgKHRvZ2dsZSBoaWRlIGlnbm9yZWQgdXNlcnMgYnViYmxlKQo6c3Bhd24gW0Z1cm5pTmFtZV0gW29wdGlvbmFsOkZ1cm5pU3RhdGVdIChzcGF3biByZXF1ZXN0ZWQgZnVybmkgYXQgY3VycmVudCB1c2VyIHBvc2l0aW9uL2RpcmVjdGlvbikgKElOIFNFUlZFUi1TSURFIENBU0VTIFVTRSBBVCBPV04gUklTSykKOmxhdWdoIChsYXVnaCBleHByZXNzaW9uLCBoYyBvbmx5KQo6ZnVybml0ZWNoIChvcGVuIHNhbmRib3ggc2VsZiBkb25hdGUgd2luZG93KSAoY2xpZW50IHNpZGUgb25seSkKOm11dGVwZXRzICh0b2dnbGUgcGV0cyBtdXRlIHdpdGggZm9yY2VkIG1vZGUpCjptdXRlYm90cyAodG9nZ2xlIGJvdHMgbXV0ZSB3aXRoIGZvcmNlZCBtb2RlKQo6bXV0ZWNtZCAodG9nZ2xlIGNvbW1hbmRzIGNoYXQgaGludHMpCjpjbGVhcmNoYXQgKGNsZWFyIHJvb20gY2hhdCkKOmNsZWFyaGlzdCAoY2xlYXIgY2hhdCBoaXN0b3J5KQo6Y2F1dGlvbiAoc2hvdy9oaWRlIG1vZGVyYXRpb24gY2F1dGlvbiBhbGVydHMpCjpoaWRlZmlndXJlcyAoaGlkZSBhbGwgdXNlcnMgd2l0aCB0aGUgY3VycmVudCBzZWxlY3RlZCBmaWd1cmUpCjpoaWRlcG9pbnRzIFtNYXhQb2ludHNdIChoaWRlIGFsbCB1c2VycyB3aXRoIGxlc3Mgb3IgZXF1YWwgYWN0aXZpdHkgcG9pbnRzKQo6bGlua3BvcnQgKGxpbmsgdGhlIHNlbGVjdGVkIHRlbGVwb3J0IHRvIGFub3RoZXIgdGVsZXBvcnQpCjpzYXZlbG9vayBbTmFtZV0gKHNhdmUgY3VycmVudCBsb29rKQo6dXNlbG9vayBbTmFtZV0gKHVzZSByZXF1ZXN0ZWQgc2F2ZWQgbG9vaykKOnJlbW92ZWxvb2sgW05hbWVdIChyZW1vdmUgcmVxdWVzdGVkIHNhdmVkIGxvb2spCjpzaG93bG9va3MgKHNob3cgc2F2ZWQgbG9va3MpCjpjbGVhcmxvb2tzIChjbGVhciBzYXZlZCBsb29rcykKOnJlc2NhbSAocmVzZXQgcm9vbSBjYW1lcmEgcG9zaXRpb24pCjp0b3RlbSAodG9nZ2xlIHRvdGVtIGhlbHBlciBmb3Igc2VsZWN0ZWQgZnVybmkpIChVU0UgQVQgT1dOIFJJU0spCjpzb2xleHAgKGV4cG9ydCBjbGllbnQgY29uZmlndXJhdGlvbi9zb2wgZmlsZSkKOnNvbGltcCAoaW1wb3J0IGNsaWVudCBjb25maWd1cmF0aW9uL3NvbCBmaWxlKQo6bmF2ZmlsdGVyICh0b2dnbGUgcm9vbSBuYXZpZ2F0b3IgZmlsdGVyIHRvIGF2b2lkIGJvdHRlZCBvciB1bndhbnRlZCByb29tcykgKHdvcmsgaW4gcHJvZ3Jlc3Mp";
         this.RejectedPollsIds = new Array();
         this.HighlightedObjectsIds = new Array();
         this.AutoClickObjectsIds = new Array();
         this.UserCustomFxTimer = new Timer(100);
         this.UserCustomFxTimer.addEventListener(TimerEvent.TIMER,this.UserCustomFxTimerHandler);
         this.AntiAfkModeTimer = new Timer(60000);
         this.AntiAfkModeTimer.addEventListener(TimerEvent.TIMER,this.AntiAfkModeTimerHandler);
         this.DevWarTimer = new Timer(1000);
         this.DevWarTimer.addEventListener(TimerEvent.TIMER,this.DevWarTimerHandler);
         this.AutoClickTimer = new Timer(200);
         this.AutoClickTimer.addEventListener(TimerEvent.TIMER,this.AutoClickTimerHandler);
         this.PetTalkTimer = new Timer(30000,1);
         this.PetTalkTimer.addEventListener(TimerEvent.TIMER,this.PetTalkTimerHandler);
         this.PetTalkMessages = new Array("lPit. bebe","Crazy bebe","-lMatheus. bebe");
         this.MilkBowlQueue = new Array();
         this.MilkBowlTimer = new Timer(600);
         this.MilkBowlTimer.addEventListener(TimerEvent.TIMER,this.MilkBowlTimerHandler);
         this.PetChatQueue = new Array();
         this.PetChatTimer = new Timer(900);
         this.PetChatTimer.addEventListener(TimerEvent.TIMER,this.PetChatTimerHandler);
         this.BallTrackTimer = new Timer(20);
         this.BallTrackTimer.addEventListener(TimerEvent.TIMER,this.BallTrackTimerHandler);
         this.BallTrackFilters = [new GlowFilter(16711680,1,40,40,8,3,false,false)];
         this.BallTrackMarkerIds = new Array(900000,900001,900002,900003,900004,900005,900006,900007,900008,900009,900010,900011,900012,900013,900014,900015,900016,900017,900018,900019,900020,900021,900022,900023,900024,900025,900026,900027,900028,900029,900030,900031,900032,900033,900034,900035,900036,900037,900038,900039,900040,900041,900042,900043,900044,900045,900046,900047,900048,900049,900050,900051,900052,900053,900054,900055,900056,900057);
         this.HiddenFurniData = new Array();
         this.EssentialFballTypes = new Array("fball_ball","fball_ball2","fball_ball3","fball_ball4","fball_ball5","fball_goal_b","fball_goal_g","fball_goal_r","fball_goal_y","fball_ptch0","fball_ptch1","fball_ptch2","fball_ptch3","fball_ptch4","fball_ptch5","fball_ptch6","fball_ptch7","fball_ptch8","fball_bench","fball_score_b","fball_score_y","fball_score_r","fball_score_g","fball_counter");
         this.TotemTimer = new Timer(500);
         this.TotemTimer.addEventListener(TimerEvent.TIMER,this.TotemTimerHandler);
         this.RoomEngineTimer = new Timer(100);
         this.RoomEngineTimer.addEventListener(TimerEvent.TIMER,this.RoomEngineTimerHandler);
         this.RoomBackgroundColorTimer = new Timer(1000);
         this.RoomBackgroundColorTimer.addEventListener(TimerEvent.TIMER,this.RoomBackgroundColorTimerHandler);
         this.RoomLightTimer = new Timer(1000);
         this.RoomLightTimer.addEventListener(TimerEvent.TIMER,this.RoomLightTimerHandler);
         this.FloodTimer = new Timer(1000);
         this.FloodTimer.addEventListener(TimerEvent.TIMER,this.FloodTimerHandler);
         this.TradeBlockTimer = new Timer(500);
         this.TradeBlockTimer.addEventListener(TimerEvent.TIMER,this.TradeBlockTimerHandler);
         this.PendingFriendsOnlineNotification = new Vector.<*>();
         this.FriendsOnlineNotificationTimer = new Timer(500);
         this.FriendsOnlineNotificationTimer.addEventListener(TimerEvent.TIMER,this.FriendsOnlineNotificationTimerHandler);
         this.RoomCameraFollowDisablerTimer = new Timer(500,1);
         this.RoomCameraFollowDisablerTimer.addEventListener(TimerEvent.TIMER,this.RoomCameraFollowDisablerTimerHandler);
         this.SpawnHelperTimer = new Timer(500);
         this.SpawnHelperTimer.addEventListener(TimerEvent.TIMER,this.SpawnHelperTimerHandler);
         this.ActiveRoomCanvasReadyTimer = new Timer(100);
         this.ActiveRoomCanvasReadyTimer.addEventListener(TimerEvent.TIMER,this.ActiveRoomCanvasReadyTimerHandler);
         this.LoadSavedVariablesValues();
         String("Fix halloween residual color bug from old client versions");
         if(this.TitleBarColor == 15752474 && BottomBarColor == 6553986 && SeasonalColorsActive == false)
         {
            this.TitleBarColor = this.HexToUintColor("#f06cd9");
            this.BottomBarColor = this.HexToUintColor("#751E4B");
            this.SaveVariablesValues();
            this.RecolorWindowFrames();
         }
         String("End of fix");
         this.UserCustomFxTimer.start();
         this.AntiAfkModeTimer.start();
         this.DevWarTimer.start();
         this.RoomEngineTimer.start();
         this.RoomBackgroundColorTimer.start();
         this.RoomLightTimer.start();
      }
      
      internal function getKeyNameFromCode(code:uint) : String
      {
         if(keyCodeNames == null)
         {
            keyCodeNames = {};
            var description:XML = describeType(Keyboard);
            for each(var constant in description.constant)
            {
               var name:String = constant.@name;
               var value:uint = uint(Keyboard[name]);
               keyCodeNames[value] = name;
            }
         }
         return keyCodeNames[code];
      }
      
      public function OnWiredTradePaymentOnly(param1:*, param2:*, param3:*, param4:*, param5:*) : void
      {
         param1.findChildByName("offerings_title").text = CapitalizeFirstLetter(WindowManager.localization.getLocalizationRaw("wiredfurni.params.time_util.mode.0").value) + ":";
         param2.findChildByName("offerings_title").text = CapitalizeFirstLetter(WindowManager.localization.getLocalizationRaw("groupcreation.generic.group_description.placeholder").value) + ":";
         var CurrentHotelDomain:* = this.WindowManager.localization.getLocalization("landing.view.hotel.domain");
         if(CurrentHotelDomain == "Habbo.es")
         {
            param3.text = "<b>NO RECIBIRÁS NINGÚN FURNI/OBJETO.<br>NO IMPORTA LO QUE DIGA LA DESCRIPCIÓN.</b>";
         }
         if(CurrentHotelDomain == "Habbo.com")
         {
            param3.text = "<b>YOU WILL NOT RECEIVE ANY FURNI/ITEM.<br>NO MATTER WHAT THE DESCRIPTION SAYS.</b>";
         }
         if(CurrentHotelDomain == "Habbo.com.br")
         {
            param3.text = "<b>VOCÊ NÃO RECEBERÁ NENHUM MOBI/ITEM.<br>NÃO IMPORTA O QUE A DESCRIÇÃO DIGA.</b>";
         }
         if(CurrentHotelDomain == "Habbo.it")
         {
            param3.text = "<b>NON RICEVERAI ALCUN FURNI/OGGETTO.<br>NON IMPORTA COSA DICA LA DESCRIZIONE.</b>";
         }
         if(CurrentHotelDomain == "Habbo.fr")
         {
            param3.text = "<b>VOUS NE RECEVREZ AUCUN MOBI/OBJET.<br>PEU IMPORTE CE QUE DIT LA DESCRIPTION.</b>";
         }
         if(CurrentHotelDomain == "Habbo.de")
         {
            param3.text = "<b>DU ERHÄLTST KEIN MÖBELSTÜCK/KEINEN GEGENSTAND.<br>EGAL, WAS IN DER BESCHREIBUNG STEHT.</b>";
         }
         if(CurrentHotelDomain == "Habbo.fi")
         {
            param3.text = "<b>ET SAA MITÄÄN FURNIA/ESINETTÄ.<br>EI OLE VÄLIÄ, MITÄ KUVAUKSESSA LUKEE.</b>";
         }
         if(CurrentHotelDomain == "Habbo.nl")
         {
            param3.text = "<b>JE ONTVANGT GEEN ENKEL FURNI/VOORWERP.<br>HET MAAKT NIET UIT WAT ER IN DE BESCHRIJVING STAAT.</b>";
         }
         if(CurrentHotelDomain == "Habbo.tr")
         {
            param3.text = "<b>HİÇBİR FURNİ/EŞYA ALMAYACAKSIN.<br>AÇIKLAMADA NE YAZDIĞININ ÖNEMİ YOK.</b>";
         }
         param1.removeChild(param4.window);
         param1.addChild(param5.window);
         param2.removeChild(param5.window);
         param2.addChild(param4.window);
         param3.height = param3.numLines * 15 + 2;
         param3.visible = true;
      }
      
      public function CapitalizeFirstLetter(param1:String) : String
      {
         return param1.charAt(0).toUpperCase() + param1.substr(1);
      }
      
      public function OnAddFurniture(param1:*, param2:String) : Boolean
      {
         if(this.AdBlockActivated == true)
         {
            if(param2.indexOf("ads_mpu") >= 0)
            {
               return false;
            }
         }
         return true;
      }
      
      public function OnNavigatorPerformSearch(param1:String, param2:String) : String
      {
         var FilteredCategories:Array = ["hotel_view","popular","recommended"];
         if(FilteredCategories.indexOf(param1.toLowerCase()) != -1 || param1.toLowerCase().indexOf("category_") == 0)
         {
            if(param2 != "")
            {
               param1 = "query";
            }
         }
         if(param1 == "query" && param2 == "")
         {
            param1 = "popular";
         }
         return param1;
      }
      
      private function sortByUserCount(param1:*, param2:*) : Number
      {
         return param2.userCount - param1.userCount;
      }
      
      public function RemoveStringSpaces(param1:String) : String
      {
         return param1.split(" ").join("");
      }
      
      public function OnNavigatorSearchResult(param1:*) : void
      {
         if(this.IsNavigatorFilterEnabled == false)
         {
            return;
         }
         var FilteredCategories:Array = ["hotel_view","popular","recommended","roomads_view","top_promotions"];
         if(FilteredCategories.indexOf(param1.searchCodeOriginal.toLowerCase()) != -1 || param1.searchCodeOriginal.toLowerCase().indexOf("category_") != -1)
         {
            if(param1.filteringData == "")
            {
               for each(var NavigatorBlock in param1.resultSet.blocks)
               {
                  var BannedUserNames:Array = [];
                  var BannedRoomNamesParts:Array = [];
                  var LimitedRoomNameParts:Array = [];
                  if(this.WindowManager.roomEngine.getProperty("environment.id") == "es")
                  {
                     BannedUserNames = ["ana","alf-corona","fran.soria","nobito"];
                     BannedRoomNamesParts = ["blackwell","bomhams","rockefeller","subastapink"];
                     LimitedRoomNameParts = [["agenciaorion",10],["agenciaatenas",10]];
                  }
                  if(this.WindowManager.roomEngine.getProperty("environment.id") == "en")
                  {
                     BannedRoomNamesParts = ["afk coin","auto dealer","dice & rare grabber","world cup giveaway","afk giveaway","giveaway by iphone-15","dice auto","auto credit"];
                  }
                  if(this.WindowManager.roomEngine.getProperty("environment.id") == "pt")
                  {
                     BannedRoomNamesParts = ["mobis 24 horas","moedas 24 horas"];
                  }
                  var i:int = NavigatorBlock.guestRooms.length - 1;
                  while(i >= 0)
                  {
                     var NavigatorBlockGuestRoom:* = NavigatorBlock.guestRooms[i];
                     var IsRoomOwnerBanned:Boolean = false;
                     if(BannedUserNames.indexOf(NavigatorBlockGuestRoom.ownerName.toLowerCase()) != -1)
                     {
                        IsRoomOwnerBanned = true;
                     }
                     var IsRoomNameBanned:Boolean = false;
                     BannedRoomNamesParts.push("cord.gg/");
                     for each(var BannedRoomNamePart in BannedRoomNamesParts)
                     {
                        if(RemoveStringSpaces(NavigatorBlockGuestRoom.roomName).toLowerCase().indexOf(BannedRoomNamePart) != -1)
                        {
                           IsRoomNameBanned = true;
                           break;
                        }
                     }
                     for each(var LimitedRoomNamePart in LimitedRoomNameParts)
                     {
                        if(RemoveStringSpaces(NavigatorBlockGuestRoom.roomName).toLowerCase().indexOf(LimitedRoomNamePart[0]) != -1 && Boolean(NavigatorBlockGuestRoom.allInRoomMuted) == false)
                        {
                           if(NavigatorBlockGuestRoom.userCount - LimitedRoomNamePart[1] > LimitedRoomNamePart[1])
                           {
                              NavigatorBlockGuestRoom.userCount -= LimitedRoomNamePart[1];
                              NavigatorBlock.guestRooms.sort(sortByUserCount);
                              NavigatorBlockGuestRoom.allInRoomMuted = true;
                           }
                           break;
                        }
                     }
                     if(IsRoomNameBanned == true || IsRoomOwnerBanned == true)
                     {
                        NavigatorBlock.guestRooms.splice(i,1);
                     }
                     i--;
                  }
               }
            }
         }
      }
      
      public function OnFriendConnected(param1:*) : void
      {
         ShowFriendOnlineNotification(param1);
      }
      
      public function OnPollReject(param1:int) : void
      {
         RejectedPollsIds.push(param1);
      }
      
      public function OnPollOffer(param1:int) : Boolean
      {
         return RejectedPollsIds.indexOf(param1) == -1;
      }
      
      public function ShowFriendOnlineNotification(param1:*) : void
      {
         if(FriendOnlineNotification == 2 && param1.relationshipStatus == 0)
         {
            return;
         }
         if(FriendOnlineNotification > 0)
         {
            PushPendingFriendsOnlineNotification(param1);
            FriendsOnlineNotificationTimer.start();
         }
      }
      
      public function PushPendingFriendsOnlineNotification(param1:*) : void
      {
         var TempPendingFriend:* = null;
         for each(TempPendingFriend in PendingFriendsOnlineNotification)
         {
            if(TempPendingFriend.name == param1.name)
            {
               return;
            }
         }
         PendingFriendsOnlineNotification.push(param1);
      }
      
      private function FriendsOnlineNotificationTimerHandler(e:TimerEvent) : void
      {
         if(FriendOnlineNotification == 0 || PendingFriendsOnlineNotification.length == 0)
         {
            FriendsOnlineNotificationTimer.stop();
            return;
         }
         if(FriendGhostFace == null)
         {
            FriendGhostFace = WindowManager.roomEngine.toolbar.roomUI.friendBarView.getAvatarFaceBitmap("hd-99999-99999");
         }
         PendingFriendFace = WindowManager.roomEngine.toolbar.roomUI.friendBarView.getAvatarFaceBitmap(PendingFriendsOnlineNotification[0].figure);
         if(PendingFriendFace.compare(FriendGhostFace) != 0)
         {
            WindowManager.localization.registerParameter("notifications.text.friend.online","user_name",PendingFriendsOnlineNotification[0].name);
            WindowManager.roomEngine.toolbar.roomUI.habboHelp.friendList.notifications.singularController.addItem(WindowManager.localization.getLocalizationRaw("notifications.text.friend.online").value,"info",PendingFriendFace);
            PendingFriendsOnlineNotification.removeAt(0);
         }
      }
      
      private function RoomCameraFollowDisablerTimerHandler(e:TimerEvent) : void
      {
         WindowManager.sessionDataManager.setRoomCameraFollowDisabled(true);
      }
      
      private function ActiveRoomCanvasReadyTimerHandler(e:TimerEvent) : void
      {
         if(DesiredRoomFractionalSize != 1)
         {
            if(this.WindowManager.roomEngine.getActiveRoomActiveCanvas() != null)
            {
               this.WindowManager.roomEngine.getActiveRoomActiveCanvas().setScale(DesiredRoomFractionalSize);
               ActiveRoomCanvasReadyTimer.stop();
            }
         }
         else
         {
            ActiveRoomCanvasReadyTimer.stop();
         }
      }
      
      public function OnHandleModeratorCaution(param1:*, param2:*) : Boolean
      {
         if(ModCautionAlertsEnabled == false)
         {
            WindowManager.roomEngine.toolbar.roomUI.habboHelp.friendList.notifications.singularController.addItem("Moderation caution alert blocked!","info",null);
            return false;
         }
         return true;
      }
      
      public function OnHabboAvatarEditorSaveCurrentSelection(param1:*) : Boolean
      {
         if(param1.isDevelopmentEditor() == true)
         {
            DevWarUserFigure = param1.figureData.getFigureString();
            DevWarUserSex = param1.figureData.gender;
            SaveVariablesValues();
            if(RoomSession != null)
            {
               RoomSession.userDataManager.getUserDataByIndex(RoomSession.ownUserRoomId).figure = param1.figureData.getFigureString();
               RoomSession.userDataManager.getUserDataByIndex(RoomSession.ownUserRoomId).sex = param1.figureData.gender;
               param1.manager.windowManager.roomEngine.updateObjectUserFigure(RoomSession.roomId,RoomSession.ownUserRoomId,param1.figureData.getFigureString(),param1.figureData.gender);
            }
            return false;
         }
         if(param1.isDevelopmentEditor() == false && DevWarUserFigure != "")
         {
            DevWarUserFigure = "";
            DevWarUserSex = "";
            DevWarAdvicePending = true;
            ShowWhisperAlert("Developer wardrobe disabled!");
            SaveVariablesValues();
            if(RoomSession != null)
            {
               param1.manager.windowManager.roomEngine.updateObjectUserFigure(RoomSession.roomId,RoomSession.ownUserRoomId,param1.figureData.getFigureString(),param1.figureData.gender);
            }
         }
         return true;
      }
      
      public function OnUserChooserClose() : void
      {
         IsUserChooserOpen = false;
      }
      
      public function OnFurniChooserClose() : void
      {
         IsFurniChooserOpen = false;
      }
      
      public function ResetUserDataManager() : void
      {
         this.WindowManager.roomEngine.roomSessionManager.getSession(int(this.WindowManager.roomEngine.activeRoomId)).userDataManager.ResetUserData();
      }
      
      private function removeUserDataByName(param1:String) : void
      {
         var latestBotData:* = null;
         try
         {
            while(true)
            {
               latestBotData = this.RoomSession.userDataManager.getUserDataByName(param1);
               if(latestBotData == null)
               {
                  break;
               }
               this.RoomSession.userDataManager.removeUserDataByRoomIndex(int(latestBotData.roomObjectId));
            }
         }
         catch(err:Error)
         {
         }
      }
      
      internal function randomRange(minNum:Number, maxNum:Number) : Number
      {
         return Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum;
      }
      
      private function RoomLightTimerHandler(e:TimerEvent) : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         if(this.RoomLight == -1 && this.RoomBacklight == -1)
         {
            this.RoomLightTimer.stop();
            this.WindowManager.roomEngine.updateObjectRoomColor(this.RoomSession.roomId,0,255,true);
         }
         else if(this.RoomLight != -1)
         {
            this.WindowManager.roomEngine.updateObjectRoomColor(this.RoomSession.roomId,0,this.RoomLight,false);
         }
         else
         {
            this.WindowManager.roomEngine.updateObjectRoomColor(this.RoomSession.roomId,0,this.RoomBacklight,true);
         }
      }
      
      private function RoomBackgroundColorTimerHandler(e:TimerEvent) : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         if(this.RoomBackgroundColors == null)
         {
            this.RoomBackgroundColorTimer.stop();
            this.WindowManager.roomEngine.updateObjectRoomBackgroundColor(this.RoomSession.roomId,true,0,0,0);
         }
         else
         {
            this.WindowManager.roomEngine.updateObjectRoomBackgroundColor(this.RoomSession.roomId,true,int(this.RoomBackgroundColors[0]),int(this.RoomBackgroundColors[1]),int(this.RoomBackgroundColors[2]));
         }
      }
      
      private function RoomEngineReady() : void
      {
         this.WindowManager.roomEngine.context.displayObjectContainer.stage.frameRate = this.DesiredFpsValue;
         this.WindowManager.roomEngine.setProperty("avatar.ignored.bubble.enabled",!HideIgnoredBubbleEnabled);
         this.WindowManager.roomEngine.context.displayObjectContainer.stage.addEventListener("keyUp",OnStageKeyUp);
         this.WindowManager.roomEngine.context.displayObjectContainer.stage.addEventListener("keyDown",OnStageKeyDown);
         this.WindowManager.roomEngine.context.displayObjectContainer.stage.addEventListener("deactivate",OnStageDeactivate);
         this.WindowManager.roomEngine.context.displayObjectContainer.stage.frameRate = this.DesiredFpsValue;
         this.WindowManager.roomEngine.context.addLinkEventTracker(this);
         if(new Date().month == 10 && new Date().fullYear == 2025)
         {
            if(SeasonalColorsEnabled == true)
            {
               SeasonalColorsActive = true;
               this.TitleBarColor = this.HexToUintColor("#F060CC");
               this.BottomBarColor = this.HexToUintColor("#088C54");
               this.WindowBlend = "0.98";
               this.BottomBarBlend = "0.5";
               this.BottomBarAltStyleEnabled = false;
               this.RecolorWindowFrames();
            }
            this.WindowManager.roomEngine.setProperty("landing.view.background_left.uri","https://images.habbo.com/c_images/reception/easter17_backgroud_left.png");
            this.WindowManager.roomEngine.setProperty("landing.view.background_right.uri","https://images.habbo.com/c_images/reception/val14_background_right.png");
            this.WindowManager.roomEngine.setProperty("landing.view.background_gradient.uri","https://images.habbo.com/c_images/reception/background_gradient_Jan25.png");
            this.WindowManager.roomEngine.setProperty("landing.view.background_gradient_top.uri","https://images.habbo.com/c_images/reception/background_gradient_Jan25.png");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.10","album1584/NPH13;randomwalk;2000;-20;0;20;20;10;750");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.11","album1584/NPH13;randomwalk;2250;-20;0;30;30;30;2000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.12","album1584/NPH13;randomwalk;2500;-20;0;30;30;30;2500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.13","album1584/NPH13;randomwalk;2750;-20;0;40;60;30;1000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.14","album1584/NPH13;randomwalk;3000;-20;0;50;40;10;2000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.15","album1584/NPH13;randomwalk;3500;-20;0;30;10;30;500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.1","album1584/NPH13;randomwalk;50;-20;0;50;10;30;500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.2","album1584/NPH13;randomwalk;250;-20;0;20;20;10;1500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.3","album1584/NPH13;randomwalk;500;-20;0;20;30;10;750");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.4","album1584/NPH13;randomwalk;750;-20;0;30;30;30;2000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.5","album1584/NPH13;randomwalk;850;-20;0;20;40;25;1700");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.6","album1584/NPH13;randomwalk;1000;-20;0;30;30;30;2500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.7","album1584/NPH13;randomwalk;1250;-20;0;50;40;10;1000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.8","album1584/NPH13;randomwalk;1500;-20;0;40;60;30;500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.9","album1584/NPH13;randomwalk;1750;-20;0;20;20;10;1500");
         }
         if(new Date().month == 9)
         {
            if(SeasonalColorsEnabled == true)
            {
               SeasonalColorsActive = true;
               this.TitleBarColor = 15752474;
               this.BottomBarColor = 6553986;
               this.WindowBlend = "1.0";
               this.BottomBarBlend = "0.5";
               this.BottomBarAltStyleEnabled = false;
               this.RecolorWindowFrames();
            }
            this.WindowManager.roomEngine.setProperty("landing.view.background_right.uri","https://images.habbo.com/c_images/reception/background_right_hween15.png");
            this.WindowManager.roomEngine.setProperty("landing.view.background_gradient.uri","https://images.habbo.com/c_images/reception/background_gradient_Oct23.png");
            this.WindowManager.roomEngine.setProperty("landing.view.background_gradient_top.uri","https://images.habbo.com/c_images/reception/background_gradient_Oct23.png");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.10","album1584/HSE23;randomwalk;2000;-20;0;20;20;10;750");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.11","album1584/HSE23;randomwalk;2250;-20;0;30;30;30;2000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.12","album1584/HSE23;randomwalk;2500;-20;0;30;30;30;2500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.13","album1584/HSE23;randomwalk;2750;-20;0;40;60;30;1000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.14","album1584/HSE23;randomwalk;3000;-20;0;50;40;10;2000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.15","album1584/HSE23;randomwalk;3500;-20;0;30;10;30;500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.1","album1584/HSE23;randomwalk;50;-20;0;50;10;30;500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.2","album1584/HSE23;randomwalk;250;-20;0;20;20;10;1500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.3","album1584/HSE23;randomwalk;500;-20;0;20;30;10;750");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.4","album1584/HSE23;randomwalk;750;-20;0;30;30;30;2000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.5","album1584/HSE23;randomwalk;850;-20;0;20;40;25;1700");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.6","album1584/HSE23;randomwalk;1000;-20;0;30;30;30;2500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.7","album1584/HSE23;randomwalk;1250;-20;0;50;40;10;1000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.8","album1584/HSE23;randomwalk;1500;-20;0;40;60;30;500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.9","album1584/HSE23;randomwalk;1750;-20;0;20;20;10;1500");
         }
         if(new Date().month == 11 || new Date().month == 0 && new Date().date == 1)
         {
            if(SeasonalColorsEnabled == true)
            {
               SeasonalColorsActive = true;
               this.TitleBarColor = this.HexToUintColor("#067511");
               this.BottomBarColor = this.HexToUintColor("#690505");
               this.WindowBlend = "0.98";
               this.BottomBarBlend = "0.5";
               this.BottomBarAltStyleEnabled = false;
               this.RecolorWindowFrames();
            }
            this.WindowManager.roomEngine.setProperty("landing.view.background_right.uri","https://images.habbo.com/c_images/reception/xmas15_background_hotel_right.png");
            this.WindowManager.roomEngine.setProperty("landing.view.background_gradient.uri","https://images.habbo.com/c_images/xmas2012/Layer_4_stars_blue_8bit.png");
            this.WindowManager.roomEngine.setProperty("landing.view.background_gradient_top.uri","https://images.habbo.com/c_images/xmas2012/Layer_4_stars_blue_8bit.png");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.10","xmas2012/snowflake_size_1;randomwalk;2000;-20;0;20;20;10;750");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.11","xmas2012/snowflake_size_2;randomwalk;2250;-20;0;30;30;30;2000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.12","xmas2012/snowflake_size_1;randomwalk;2500;-20;0;30;30;30;2500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.13","xmas2012/snowflake_size_2blurred;randomwalk;2750;-20;0;40;60;30;1000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.14","xmas2012/snowflake_size_2;randomwalk;3000;-20;0;50;40;10;2000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.15","xmas2012/snowflake_size_1;randomwalk;3500;-20;0;30;10;30;500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.1","xmas2012/snowflake_size_1;randomwalk;50;-20;0;50;10;30;500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.2","xmas2012/snowflake_size_2;randomwalk;250;-20;0;20;20;10;1500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.3","xmas2012/snowflake_size_1_blurred;randomwalk;500;-20;0;20;30;10;750");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.4","xmas2012/snowflake_size_2;randomwalk;750;-20;0;30;30;30;2000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.5","xmas2012/snowflake_size_2;randomwalk;850;-20;0;20;40;25;1700");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.6","xmas2012/snowflake_size_1_blurred;randomwalk;1000;-20;0;30;30;30;2500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.7","xmas2012/snowflake_size_2;randomwalk;1250;-20;0;50;40;10;1000");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.8","xmas2012/snowflake_size_1;randomwalk;1500;-20;0;40;60;30;500");
            this.WindowManager.roomEngine.setProperty("landing.view.bgobject.9","xmas2012/snowflake_size_2blurred;randomwalk;1750;-20;0;20;20;10;1500");
         }
      }
      
      private function RoomEngineTimerHandler(e:TimerEvent) : void
      {
         if(this.WindowManager.roomEngine != null)
         {
            this.RoomEngineTimer.stop();
            this.RoomEngineReady();
         }
      }
      
      private function FriendGiveGemConfirm(param1:*, param2:*) : void
      {
         if(param2.type == "WE_OK")
         {
            this.WindowManager.communication.connection.send(new GiveStarGemToUserMessageComposer(this.FriendGiveGemID,this.FriendGiveGemAmount));
         }
         param1.dispose();
      }
      
      public function get linkPattern() : String
      {
         return "LilithCustoms/";
      }
      
      public function linkReceived(param1:String) : void
      {
         if(param1 == "LilithCustoms/OpenGithubLatestRelease")
         {
            HabboWebTools.navigateToURL("https://github.com/LilithRainbows/HabboAirPlus/releases/latest","habboMain");
         }
         if(param1 == "LilithCustoms/About")
         {
            this.WindowManager.simpleAlert("About HabboAirPlus","Version 05/08/2026 (DD/MM/AAAA)","Based on WIN63-202607011411-782849652\n\nEdited by Lilith.\nSulake Oy. All rights reserved.\nProject not endorsed by or affiliated with Sulake Oy.");
         }
      }
      
      public function OnWalkTo(param1:*, param2:*) : Boolean
      {
         this.RunMandiocaFritaEffect(param1, param2);
         return WalkEnabled;
      }
      
      public function OnTradingOpen(param1:*) : Boolean
      {
         IsTradingOpen = true;
         return TradeEnabled;
      }
      
      public function OnTradingClose(param1:*) : Boolean
      {
         IsTradingOpen = false;
         return TradeEnabled;
      }
      
      public function OnShowUserNameEntranceHighlight(param1:*) : Boolean
      {
         if(param1.type == 1 && FriendHighlightEnabled == true)
         {
            return true;
         }
         return false;
      }
      
      private function TradeBlockTimerHandler(e:TimerEvent) : void
      {
         if(IsTradingOpen && TradeEnabled == false)
         {
            this.WindowManager.communication.connection.send(new CloseTradingComposer());
         }
      }
      
      public function OnIsPerkAllowed(param1:String) : *
      {
         if(param1 == "MOUSE_ZOOM")
         {
            return this.ZoomGesturesEnabled;
         }
         return null;
      }
      
      public function OnHabboPageOpen(param1:*) : String
      {
         var HabboPageTitle:* = undefined;
         var HabboPageHeader:* = undefined;
         if(param1 == "chat/commands")
         {
            HabboPageTitle = "HabboAirPlus Commands";
            HabboPageHeader = "<span class=\"padding-top\">";
            HabboPageHeader += "<a href=\"event:LilithCustoms/About\"><img src=\"https://images.habbo.com/c_images/album1584/US416.png\" vspace=\"1\" align=\"right\" hspace=\"1\"></a>";
            HabboPageHeader += "<br></span><p>See also: <a href=\"event:habbopages/chat/commands?\">Official Habbo commands</a></p><span class=\"padding-bottom\"><br></span><font size=\"14px\">";
            return HabboPageTitle + "\n" + HabboPageHeader + "<br>" + Base64.decode(this.AirPlusCommandsHabboPageBase64).split("\n").join("<br><br>");
         }
         return "";
      }
      
      public function HandlePossibleHotKey(param1:*) : void
      {
         if(this.HotKeyPendingToSet && param1.keyCode != 13)
         {
            this.SetHotKey(param1.keyCode);
            return;
         }
         if(HotKeysDictionary == null)
         {
            return;
         }
         var RequestedHotKeyValue:String = String(this.HotKeysDictionary[String(param1.keyCode)]);
         if(RequestedHotKeyValue != "undefined" && RequestedHotKeyValue != "")
         {
            this.WindowManager.roomEngine.toolbar.roomUI.desktop.getWidget("RWE_CHAT_INPUT_WIDGET").sendChat(RequestedHotKeyValue,0,"",this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle);
         }
      }
      
      public function OnStageKeyDown(param1:*) : void
      {
         if(ShiftWalkBlockEnabled && param1.keyCode == 16)
         {
            RoomObjectMouseKeyboardShortcutsEnabled = false;
            WalkEnabled = false;
         }
         if(CtrlUseFurniOnSingleClickEnabled && param1.keyCode == 17)
         {
            RoomObjectMouseKeyboardShortcutsEnabled = false;
            UseFurniOnSingleClickEnabled = true;
         }
         if(HotKeyPressMode == "down")
         {
            HandlePossibleHotKey(param1);
         }
      }
      
      public function OnStageKeyUp(param1:*) : void
      {
         if(ShiftWalkBlockEnabled && param1.keyCode == 16)
         {
            RoomObjectMouseKeyboardShortcutsEnabled = true;
            WalkEnabled = true;
         }
         if(CtrlUseFurniOnSingleClickEnabled && param1.keyCode == 17)
         {
            RoomObjectMouseKeyboardShortcutsEnabled = true;
            UseFurniOnSingleClickEnabled = false;
         }
         if(HotKeyPressMode == "up")
         {
            HandlePossibleHotKey(param1);
         }
      }
      
      public function OnStageDeactivate(param1:*) : void
      {
         if(ShiftWalkBlockEnabled)
         {
            RoomObjectMouseKeyboardShortcutsEnabled = true;
            WalkEnabled = true;
         }
         if(CtrlUseFurniOnSingleClickEnabled)
         {
            RoomObjectMouseKeyboardShortcutsEnabled = true;
            UseFurniOnSingleClickEnabled = false;
         }
      }
      
      public function OnChatInputKeyUp(param1:*) : void
      {
         var PossibleChatCommand_Temp:String = null;
         var PossibleChatCommand_Final:String = null;
         var CurrentChatInput:* = null;
         if(param1.keyCode == 9 && this.CommandInputColorHintActivated == true)
         {
            CurrentChatInput = this.GetChatInputElement();
            PossibleChatCommand_Final = "";
            if(CurrentChatInput.text.indexOf(":") == 0)
            {
               for each(PossibleChatCommand_Temp in this.AllowedCommands)
               {
                  if(PossibleChatCommand_Temp.indexOf(CurrentChatInput.text) == 0)
                  {
                     if(PossibleChatCommand_Final == "")
                     {
                        PossibleChatCommand_Final = PossibleChatCommand_Temp;
                     }
                     else
                     {
                        PossibleChatCommand_Final = "BLOCKED";
                     }
                  }
               }
            }
            if(PossibleChatCommand_Final != "BLOCKED" && PossibleChatCommand_Final != "" && CurrentChatInput.text != PossibleChatCommand_Final)
            {
               CurrentChatInput.text = PossibleChatCommand_Final;
               CurrentChatInput.setSelection(PossibleChatCommand_Final.length,PossibleChatCommand_Final.length);
               this.OnChatInputChanged(CurrentChatInput);
            }
         }
      }
      
      public function SetHotKey(param1:int) : void
      {
         if(this.HotKeysDictionary == null)
         {
            this.HotKeysDictionary = new Dictionary();
         }
         this.HotKeysDictionary[String(param1)] = String(this.HotKeyPendingValue);
         if(String(this.HotKeyPendingValue) == "")
         {
            this.ShowWhisperAlert("Hotkey set ready! [empty]");
         }
         else
         {
            this.ShowWhisperAlert("Hotkey set ready! [chat input]");
         }
         this.HotKeyPendingToSet = false;
         this.HotKeyPendingValue = "";
         this.SaveVariablesValues();
      }
      
      public function OnWardrobe(param1:Array) : void
      {
         ConfigureWardrobePage(0,param1);
         ConfigureLocalWardrobeSlots();
         if(WindowManager.sessionDataManager.clubLevel == 0)
         {
            LoadWardrobePage(1);
         }
         else
         {
            LoadWardrobePage(0);
         }
      }
      
      public function ConfigureLocalWardrobeSlots() : void
      {
         for(var key in WardrobePagesDictionary)
         {
            if(key != "page_0")
            {
               delete WardrobePagesDictionary[key];
            }
         }
         var maxSlot:int = 0;
         for(var SavedLook in SavedLooksDictionary)
         {
            if(SavedLook.indexOf("slot_") == 0)
            {
               var slot:int = int(SavedLook.split("_")[1]);
               if(slot > maxSlot)
               {
                  maxSlot = slot;
               }
            }
         }
         var totalPages:int = Math.ceil(maxSlot / 14) + 1;
         var page:int = 1;
         while(page <= totalPages)
         {
            var outfits:Array = [];
            var i:int = 1;
            while(i <= 14)
            {
               outfits.push(new OutfitData(null,i,"hd-99999-99999","M"));
               i++;
            }
            var firstSlot:int = (page - 1) * 14 + 1;
            var lastSlot:int = firstSlot + 13;
            for(SavedLook in SavedLooksDictionary)
            {
               if(SavedLook.indexOf("slot_") == 0)
               {
                  slot = int(SavedLook.split("_")[1]);
                  if(slot >= firstSlot && slot <= lastSlot)
                  {
                     var localSlot:int = slot - firstSlot + 1;
                     var requestedLook:String = SavedLooksDictionary[SavedLook];
                     var figure:String = requestedLook.split(" ")[0];
                     var sex:String = requestedLook.split(" ")[1];
                     outfits[localSlot - 1] = new OutfitData(null,localSlot,figure,sex);
                  }
               }
            }
            ConfigureWardrobePage(page,outfits);
            page++;
         }
      }
      
      public function OnWardrobeSlotEventHandler(param1:*, param2:*, param3:int) : Boolean
      {
         if(CurrentWardrobePage == 0)
         {
            if(param2.name == "set_button" && WindowManager.sessionDataManager.hasVip)
            {
               WardrobePagesDictionary["page_0"][param1.id] = new OutfitData(null,param1.id,WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(param3).figureData.getFigureString(),WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(param3).figureData.gender);
            }
            return true;
         }
         var realslotindex:* = param1.id + 14 * (CurrentWardrobePage - 1);
         if(param2.name == "set_button")
         {
            SaveLookSilent("slot_" + realslotindex,WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(param3).figureData.getFigureString(),WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(param3).figureData.gender);
         }
         if(param2.name == "get_button" || param2.name == "get_figure")
         {
            var SavedEntry:* = GetSavedLookEntry("slot_" + realslotindex);
            if(SavedEntry != null)
            {
               this.WindowManager.roomEngine.toolbar.roomUI.catalog.avatarEditor.loadAvatarInEditor(param3,SavedEntry.figure,SavedEntry.gender);
            }
         }
         if(param2.name == "delete_button")
         {
            RemoveSavedLookByExactName("slot_" + realslotindex);
         }
         ConfigureLocalWardrobeSlots();
         LoadWardrobePage(CurrentWardrobePage);
         return false;
      }
      
      private function OnWardrobePrevPageButtonClick(param1:*, param2:*) : void
      {
         if(param1.type != "WME_CLICK" || CurrentWardrobePage == 0)
         {
            return;
         }
         LoadWardrobePage(CurrentWardrobePage - 1);
      }
      
      private function OnWardrobeNextPageButtonClick(param1:*, param2:*) : void
      {
         if(param1.type != "WME_CLICK" || CurrentWardrobePage == WardrobePagesCount)
         {
            return;
         }
         LoadWardrobePage(CurrentWardrobePage + 1);
      }
      
      public function LoadWardrobePage(param1:int) : void
      {
         if(this.WardrobePagesDictionary != null)
         {
            var EditorIndexes:Array = [];
            if(WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(0) != null)
            {
               EditorIndexes.push(0);
            }
            if(WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(3) != null)
            {
               EditorIndexes.push(3);
            }
            for each(var EditorIndex in EditorIndexes)
            {
               WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(EditorIndex).wardrobe.updateSlots(1,WardrobePagesDictionary["page_" + param1]);
               if(param1 == 0)
               {
                  WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(EditorIndex).wardrobe.getWindowContainer().findChildByName("hc_icon").style = 13;
               }
               else
               {
                  WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(EditorIndex).wardrobe.getWindowContainer().findChildByName("hc_icon").style = 45;
                  String("29");
               }
               var count:int = 0;
               for(var key in WardrobePagesDictionary)
               {
                  count++;
               }
               WardrobePagesCount = count - 1;
               WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(EditorIndex).wardrobe.getWindowContainer().findChildByName("title").caption = param1 + "/" + WardrobePagesCount;
               if(param1 > WardrobePagesCount)
               {
                  LoadWardrobePage(WardrobePagesCount);
                  return;
               }
               var prevpagebtn:* = WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(EditorIndex).wardrobe.getWindowContainer().findChildByName("prev_page_button");
               prevpagebtn.id = EditorIndex;
               prevpagebtn.procedure = OnWardrobePrevPageButtonClick;
               var nextpagebtn:* = WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(EditorIndex).wardrobe.getWindowContainer().findChildByName("next_page_button");
               nextpagebtn.id = EditorIndex;
               nextpagebtn.procedure = OnWardrobeNextPageButtonClick;
               CurrentWardrobePage = param1;
               for each(var Slotsito in WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(EditorIndex).wardrobe.slots)
               {
                  if(Slotsito.figure == "hd-99999-99999")
                  {
                     Slotsito.view.findChildByName("image").visible = false;
                     Slotsito.view.findChildByName("set_button").visible = true;
                     Slotsito.view.findChildByName("get_button").visible = false;
                     Slotsito.view.findChildByName("delete_button").visible = false;
                  }
                  else
                  {
                     Slotsito.view.findChildByName("image").visible = true;
                     Slotsito.view.findChildByName("set_button").visible = true;
                     Slotsito.view.findChildByName("get_button").visible = true;
                     if(param1 == 0)
                     {
                        Slotsito.view.findChildByName("delete_button").visible = false;
                     }
                     else
                     {
                        Slotsito.view.findChildByName("delete_button").visible = true;
                     }
                  }
               }
            }
         }
      }
      
      public function ConfigureWardrobePage(param1:int, param2:Array) : void
      {
         if(this.WardrobePagesDictionary == null)
         {
            this.WardrobePagesDictionary = new Dictionary();
         }
         if(param1 == 0)
         {
            var OutfitDataArray:Array = [];
            var i:int = 1;
            while(i <= 14)
            {
               OutfitDataArray.push(new OutfitData(null,i,"hd-99999-99999","M"));
               i++;
            }
            for each(var HcLook in param2)
            {
               OutfitDataArray[HcLook.slotId - 1] = HcLook;
            }
            param2 = OutfitDataArray;
         }
         WardrobePagesDictionary["page_" + param1] = param2;
      }
      
      public function SaveLook(param1:String) : void
      {
         if(param1.replace(/\s+/g,"") == "")
         {
            ShowWhisperAlert("Look name cannot be empty!");
            return;
         }
         if(this.SavedLooksDictionary == null)
         {
            this.SavedLooksDictionary = new Dictionary();
         }
         this.SavedLooksDictionary[param1] = WindowManager.sessionDataManager.figure + " " + WindowManager.sessionDataManager.gender;
         this.SaveVariablesValues();
         this.ShowWhisperAlert("Look saved!");
      }
      
      public function RemoveSavedLook(param1:String) : void
      {
         if(SavedLooksDictionary == null)
         {
            return;
         }
         if(param1.replace(/\s+/g,"") == "")
         {
            ShowWhisperAlert("Look name cannot be empty!");
            return;
         }
         var LooksToDelete:Array = [];
         for(var SavedLook in SavedLooksDictionary)
         {
            if(SavedLook.toLowerCase().indexOf(param1.toLowerCase()) == 0)
            {
               LooksToDelete.push(SavedLook);
            }
         }
         for each(var LookToDelete in LooksToDelete)
         {
            delete SavedLooksDictionary[LookToDelete];
         }
         this.SaveVariablesValues();
         ShowWhisperAlert(LooksToDelete.length + " looks deleted!");
      }
      
      public function GetSavedLook(param1:String) : String
      {
         if(SavedLooksDictionary == null || param1.replace(/\s+/g,"") == "")
         {
            return "";
         }
         for(var SavedLook in SavedLooksDictionary)
         {
            if(SavedLook.toLowerCase().indexOf(param1.toLowerCase()) == 0)
            {
               return SavedLooksDictionary[SavedLook];
            }
         }
         return "";
      }
      
      public function ShowSavedLooks() : void
      {
         if(SavedLooksDictionary == null || SavedLooksDictionary.count == 0)
         {
            return;
         }
         var IsEmpty:Boolean = true;
         var SavedLooksList:String = "Saved looks:\n";
         for(var SavedLook in SavedLooksDictionary)
         {
            SavedLooksList += "-" + SavedLook + "\n";
            IsEmpty = false;
         }
         if(IsEmpty == false)
         {
            ShowWhisperAlert(SavedLooksList);
         }
         else
         {
            ShowWhisperAlert("There are no saved looks!");
         }
      }
      
      public function GetSavedLooksAsList() : Array
      {
         var ResultList:Array = [];
         if(SavedLooksDictionary == null)
         {
            return ResultList;
         }
         var SavedLookEntry:String = null;
         for(var SavedLookKey in SavedLooksDictionary)
         {
            SavedLookEntry = SavedLooksDictionary[SavedLookKey] as String;
            if(SavedLookEntry != null)
            {
               var SpaceIndex:int = int(SavedLookEntry.indexOf(" "));
               var FigureValue:String = SpaceIndex >= 0 ? SavedLookEntry.substring(0,SpaceIndex) : SavedLookEntry;
               var GenderValue:String = SpaceIndex >= 0 ? SavedLookEntry.substring(SpaceIndex + 1) : "M";
               ResultList.push({
                  "name":String(SavedLookKey),
                  "figure":FigureValue,
                  "gender":GenderValue
               });
            }
         }
         ResultList.sortOn("name",Array.CASEINSENSITIVE);
         return ResultList;
      }
      
      public function SaveLookSilent(param1:String, param2:String = null, param3:String = null) : void
      {
         if(param1 == null || param1.replace(/\s+/g,"") == "")
         {
            return;
         }
         if(this.SavedLooksDictionary == null)
         {
            this.SavedLooksDictionary = new Dictionary();
         }
         var FigureToStore:String = param2 ?? WindowManager.sessionDataManager.figure;
         var GenderToStore:String = param3 ?? WindowManager.sessionDataManager.gender;
         this.SavedLooksDictionary[param1] = FigureToStore + " " + GenderToStore;
         this.SaveVariablesValues();
      }
      
      public function GetSavedLookEntry(param1:String) : Object
      {
         if(SavedLooksDictionary == null || param1 == null)
         {
            return null;
         }
         var Entry:String = SavedLooksDictionary[param1] as String;
         if(Entry == null)
         {
            return null;
         }
         var SpaceIndex:int = int(Entry.indexOf(" "));
         var FigureValue:String = SpaceIndex >= 0 ? Entry.substring(0,SpaceIndex) : Entry;
         var GenderValue:String = SpaceIndex >= 0 ? Entry.substring(SpaceIndex + 1) : "M";
         return {
            "name":param1,
            "figure":FigureValue,
            "gender":GenderValue
         };
      }
      
      public function SaveCurrentLookFromAvatarEditor(param1:String = null, param2:String = null) : String
      {
         if(this.SavedLooksDictionary == null)
         {
            this.SavedLooksDictionary = new Dictionary();
         }
         var GeneratedName:String = "look_1";
         var ExistingNumber:int = 1;
         while(this.SavedLooksDictionary[GeneratedName] != null)
         {
            ExistingNumber++;
            GeneratedName = "look_" + ExistingNumber;
         }
         var FigureToStore:String = param1 ?? WindowManager.sessionDataManager.figure;
         var GenderToStore:String = param2 ?? WindowManager.sessionDataManager.gender;
         this.SavedLooksDictionary[GeneratedName] = FigureToStore + " " + GenderToStore;
         this.SaveVariablesValues();
         this.ShowWhisperAlert("Look saved as \"" + GeneratedName + "\"!");
         return GeneratedName;
      }
      
      public function RemoveSavedLookByExactName(param1:String) : Boolean
      {
         if(SavedLooksDictionary == null || param1 == null)
         {
            return false;
         }
         if(SavedLooksDictionary[param1] == null)
         {
            return false;
         }
         delete SavedLooksDictionary[param1];
         this.SaveVariablesValues();
         return true;
      }
      
      public function OnChatInputChanged(param1:*) : void
      {
         if(this.CommandInputColorHintActivated == false)
         {
            param1.textBackground = false;
            return;
         }
         if(this.IsValidCommand(param1.text))
         {
            param1.textBackgroundColor = 8512385;
         }
         else
         {
            param1.textBackgroundColor = 14909835;
         }
      }
      
      public function IsValidCommand(param1:*) : Boolean
      {
         var ChatInputSplit:Array = param1.split(" ");
         if(param1 == ": x" || param1.indexOf(": x ") == 0)
         {
            return true;
         }
         if(ChatInputSplit.length > 0)
         {
            if(this.AllowedCommands.indexOf(ChatInputSplit[0].toLowerCase()) != -1)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function OnRoomChat(param1:*) : *
      {
         var IncomingChatUserId:int = int(param1.userId);
         var IncomingChatStyleId:int = int(param1.style);
         var IncomingChatText:String = param1.text;
         var CurrentChatBubble:int = 0;
         if(this.RoomSession == null || this.RoomSession.userDataManager == null || this.RoomSession.userDataManager.getUserDataByIndex(IncomingChatUserId) == null)
         {
            return new RoomSessionChatEvent("NULL",null,0,"");
         }
         if(ChatAlarmText != "")
         {
            if(param1.text.toLowerCase().indexOf(ChatAlarmText.toLowerCase()) != -1)
            {
               this.WindowManager.catalog.soundManager.playSound("FURNITURE_cuckoo_clock");
            }
         }
         if(this.SpoofBubbles.indexOf("_") >= 0 && param1.style != 34)
         {
            CurrentChatBubble = int(this.SpoofBubbles.substring(this.SpoofBubbles.indexOf("_") + 1));
            if(CurrentChatBubble < 0)
            {
               CurrentChatBubble = 0;
            }
            if(this.SpoofBubbles.indexOf("all_") >= 0 || this.SpoofBubbles.indexOf("own_") >= 0 && param1.userId == this.RoomSession.ownUserRoomId)
            {
               IncomingChatStyleId = CurrentChatBubble;
            }
         }
         if(this.ChatTextColorEnabled == false && ChatStyleIsNotification(IncomingChatStyleId) == false)
         {
            IncomingChatText = this.TryRemoveChatTextColor(IncomingChatText);
         }
         if((MutePetsEnabled == true || MuteBotsEnabled == true) && this.IsRoomSessionAvailable)
         {
            var SelectedAvatarData:* = null;
            SelectedAvatarData = this.RoomSession.userDataManager.getUserDataByIndex(param1.userId);
            if(SelectedAvatarData != null)
            {
               if(MutePetsEnabled && SelectedAvatarData.type == 2 || MuteBotsEnabled == true && (SelectedAvatarData.type == 3 || SelectedAvatarData.type == 4))
               {
                  return new RoomSessionChatEvent("NULL",null,0,"");
               }
            }
         }
         return new RoomSessionChatEvent("RSCE_CHAT_EVENT",this.RoomSession,param1.userId,IncomingChatText,param1.chatType,IncomingChatStyleId,param1.links,param1.extraParam);
      }
      
      private function ChatStyleIsNotification(param1:int) : Boolean
      {
         return param1 == 34 || param1 >= 200 && param1 < 300;
      }
      
      public function TryRemoveChatTextColor(param1:String) : String
      {
         var PossibleChatTextColor:String = null;
         for each(PossibleChatTextColor in this.ChatTextColors)
         {
            if(param1.indexOf(PossibleChatTextColor) == 0)
            {
               return param1.substr(PossibleChatTextColor.length);
            }
         }
         return param1;
      }
      
      public function TryRemoveChatTextMods(param1:String) : String
      {
         var PossibleChatTextMod:String = null;
         for each(PossibleChatTextMod in this.ChatTextSpecialMods)
         {
            while(param1.indexOf(PossibleChatTextMod) != -1)
            {
               param1 = param1.replace(PossibleChatTextMod,"");
            }
         }
         return param1;
      }
      
      private function SpawnHelperTimerHandler(e:TimerEvent) : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            SpawnHelperTimer.stop();
            return;
         }
         var CurrentUserLocation:* = null;
         if(this.WindowManager.localization.getLocalization("landing.view.hotel.domain") == "Habbo.es")
         {
            if(this.RoomSession.roomId == 106298941)
            {
               CurrentUserLocation = this.GetOwnUserLocation();
               if(CurrentUserLocation.x == 9 && (CurrentUserLocation.y == 14 || CurrentUserLocation.y == 15))
               {
                  RoomSession.sendVisitFlatMessage(125599603);
               }
            }
            if(this.RoomSession.roomId == 125599603)
            {
               CurrentUserLocation = this.GetOwnUserLocation();
               if(CurrentUserLocation.x == 8 && CurrentUserLocation.y == 41)
               {
                  RoomSession.sendVisitFlatMessage(106298941);
               }
            }
         }
      }
      
      public function SpawnPalazzoPizzaMpu() : void
      {
         var mpu_data:* = new Map();
         mpu_data.add("state","0");
         mpu_data.add("offsetX","13");
         mpu_data.add("offsetY","3");
         mpu_data.add("offsetZ","9892");
         mpu_data.add("imageUrl","https://github.com/LilithRainbows/HabboExperiments/releases/download/latest/PizzaPlaceMpu.png");
         FakeFurniId += 1;
         this.WindowManager.roomEngine.addObjectFurnitureByName(this.RoomSession.roomId,FakeFurniId,"ads_background",new Vector3d(15,53,4),new Vector3d(0),0,new MapStuffData(mpu_data));
      }
      
      public function SpawnHall2PizzaAddon() : void
      {
         var mpu_data:* = new Map();
         mpu_data.add("state","0");
         mpu_data.add("offsetX","-3");
         mpu_data.add("offsetY","-41");
         mpu_data.add("offsetZ","666");
         mpu_data.add("imageUrl","https://github.com/LilithRainbows/HabboExperiments/releases/download/latest/hall2_b_pizza_addon.png");
         FakeFurniId += 1;
         this.WindowManager.roomEngine.addObjectFurnitureByName(this.RoomSession.roomId,FakeFurniId,"ads_background",new Vector3d(9,16,0),new Vector3d(0),0,new MapStuffData(mpu_data));
      }
      
      public function OnRoomEnter(param1:*) : void
      {
         if(this.WindowManager.roomEngine == null)
         {
            return;
         }
         ActiveRoomCanvasReadyTimer.start();
         if(IsFurniChooserOpen == true)
         {
            this.WindowManager.roomEngine.toolbar.roomUI.desktop.processWidgetMessage(new RoomWidgetRequestWidgetMessage("RWRWM_FURNI_CHOOSER"));
         }
         if(IsUserChooserOpen == true)
         {
            this.WindowManager.roomEngine.toolbar.roomUI.desktop.processWidgetMessage(new RoomWidgetRequestWidgetMessage("RWRWM_USER_CHOOSER"));
         }
         this.LastAddedObjectId = 0;
         this.AutoClickTimer.stop();
         this.TotemTimer.stop();
         this.FloodTimer.stop();
         this.FakeFurniId = 0;
         this.BallTrackActive = false;
         this.BallTrackMarkersSpawned = false;
         this.BallTrackLastTileX = -9999;
         this.BallTrackLastTileY = -9999;
         this.BallTrackTimer.stop();
         this.MilkBowlTimer.stop();
         this.MilkBowlQueue = new Array();
         this.PetChatTimer.stop();
         this.PetChatQueue = new Array();
         this.FurniHideActive = false;
         this.HiddenFurniData = new Array();
         this.SpawnHelperTimer.stop();
         this.ToggleObjectHighLigther(false);
         this.LinkPortRequested = false;
         if(this.IsRoomSessionAvailable)
         {
            if(this.AnimationFpsUnlocked)
            {
               this.WindowManager.roomEngine.getRoomCanvasGeometry(this.RoomSession.roomId,1).LockAnimationFPS = false;
            }
         }
         var CurrentHotelDomain:* = this.WindowManager.localization.getLocalization("landing.view.hotel.domain");
         var ReplacedTranslation:* = "";
         if(CurrentHotelDomain == "Habbo.es")
         {
            ReplacedTranslation = "NUNCA ingreses a un enlace/sitio web externo, no importa lo que prometan, intentan engañarte para robar tu cuenta.";
            this.WindowManager.localization.updateLocalization("new_furni_chooser.owner_selector.default","Todo");
            this.WindowManager.localization.updateLocalization("new_user_chooser.usertype.all","Todo");
            this.WindowManager.localization.updateLocalization("new_user_chooser.amount_indicator","%amount% entidades encontradas");
            this.WindowManager.localization.updateLocalization("error_window.ok","Cerrar");
            this.WindowManager.localization.updateLocalization("error_window.copy","Copiar");
            if(this.RoomSession.roomId == 106298941)
            {
               FakeFurniId += 1;
               this.WindowManager.roomEngine.addObjectFurnitureByName(this.RoomSession.roomId,FakeFurniId,"room_wl15_teleblock",new Vector3d(9,14,0),new Vector3d(90),0,new EmptyStuffData());
               FakeFurniId += 1;
               this.WindowManager.roomEngine.addObjectFurnitureByName(this.RoomSession.roomId,FakeFurniId,"room_wl15_teleblock",new Vector3d(9,15,0),new Vector3d(90),0,new EmptyStuffData());
               SpawnHall2PizzaAddon();
               this.SpawnHelperTimer.start();
            }
            if(this.RoomSession.roomId == 125599603)
            {
               FakeFurniId += 1;
               this.WindowManager.roomEngine.addObjectFurnitureByName(this.RoomSession.roomId,FakeFurniId,"room_wl15_teleblock",new Vector3d(8,41,2),new Vector3d(0),0,new EmptyStuffData());
               SpawnPalazzoPizzaMpu();
               this.SpawnHelperTimer.start();
            }
         }
         if(CurrentHotelDomain == "Habbo.com")
         {
            ReplacedTranslation = "NEVER visit an external link/website, no matter what they promise, they try to trick you into stealing your account.";
         }
         if(CurrentHotelDomain == "Habbo.com.br")
         {
            ReplacedTranslation = "NUNCA acesse um link/site externo, não importa o que prometam, estão tentando enganar você para roubar sua conta.";
         }
         if(CurrentHotelDomain == "Habbo.it")
         {
            ReplacedTranslation = "MAI accedere a un link/sito web esterno, non importa le promesse, cercheranno di rubare il tuo account.";
         }
         this.WindowManager.localization.updateLocalization("gift.untrusted.banner.text",ReplacedTranslation);
      }
      
      private function FloodTimerHandler(e:TimerEvent) : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            this.FloodTimer.stop();
            return;
         }
         this.WindowManager.roomEngine.toolbar.roomUI.desktop.getWidget("RWE_CHAT_INPUT_WIDGET").sendChat(this.FloodText,0,"",this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle);
      }
      
      private function ToggleHighlightedObjectsVisibility(param1:Array, param2:Boolean) : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         var HighlightedObject:int = 0;
         for each(HighlightedObject in param1)
         {
            if(param2)
            {
               this.RoomObjectHighLighter.show(HighlightedObject,false,100);
            }
            else
            {
               this.RoomObjectHighLighter.hide(HighlightedObject,false,100);
            }
         }
      }
      
      private function TotemTimerHandler(e:TimerEvent) : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         var FurniId:int = int(TotemFurni[0]);
         var FurniLocation:* = TotemFurni[1];
         var FurniState:int = int(TotemFurni[2]);
         var FurniHandleState:int = int(TotemFurni[3]);
         if(FurniHandleState == -1)
         {
            TotemTimer.stop();
            FurniHandleState = 2;
            ShowWhisperAlert("Totem helper stopped!");
         }
         if(FurniHandleState == 0)
         {
            this.WindowManager.roomEngine.useRoomObjectInActiveRoom(FurniId,10);
            TotemFurni[3] = 1;
            return;
         }
         if(FurniHandleState == 1)
         {
            WindowManager.roomEngine.modifyRoomObject(FurniId,10,"OBJECT_PICKUP");
            TotemFurni[3] = 2;
            return;
         }
         if(FurniHandleState == 2)
         {
            this.WindowManager.communication.connection.send(new PlaceObjectMessageComposer(-FurniId,10,"",FurniLocation.x,FurniLocation.y,0));
            TotemFurni[3] = 0;
            return;
         }
      }

      private function PetTalkTimerHandler(e:TimerEvent) : void
      {
         if(this.PetTalkActive == false)
         {
            return;
         }
         if(this.IsRoomSessionAvailable == true)
         {
            var MessageIndex:int = 0;
            this.PetChatQueue = new Array();
            for(MessageIndex = 0; MessageIndex < this.PetTalkMessages.length; MessageIndex++)
            {
               this.PetChatQueue.push(String(this.PetTalkMessages[MessageIndex]));
            }
            this.PetChatTimer.stop();
            if(this.PetChatQueue.length > 0)
            {
               this.PetChatTimer.start();
            }
            this.UseMilkBowls();
         }
         this.PetTalkTimer.delay = 10000;
         this.PetTalkTimer.reset();
         this.PetTalkTimer.start();
      }

      private function BallTrackTimerHandler(e:TimerEvent) : void
      {
         if(this.BallTrackActive == false || this.IsRoomSessionAvailable == false)
         {
            this.BallTrackTimer.stop();
            return;
         }
         var TrackedFurni:* = this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,this.BallTrackFurniId,10);
         if(TrackedFurni == null)
         {
            this.ShowWhisperAlert("Bola não encontrada, sinalizador desligado!");
            this.BallTrackActive = false;
            this.BallTrackTimer.stop();
            this.ClearBallTrackMarkers();
            return;
         }
         var BallLocation:* = TrackedFurni.getLocation();
         var BallTileX:int = int(Math.round(BallLocation.x));
         var BallTileY:int = int(Math.round(BallLocation.y));
         if(BallTileX != this.BallTrackLastTileX || BallTileY != this.BallTrackLastTileY || this.BallTrackMarkersSpawned == false)
         {
            this.UpdateBallTrackMarkers(BallTileX,BallTileY,BallLocation.z);
            this.BallTrackLastTileX = BallTileX;
            this.BallTrackLastTileY = BallTileY;
         }
      }

      private function UpdateBallTrackMarkers(CenterX:int, CenterY:int, CenterZ:Number) : void
      {
         var Directions:Array = [[0,-1],[0,1],[-1,0],[1,0],[-1,-1],[1,-1],[-1,1],[1,1]];
         var LineLength:int = 6;
         var MarkerIndex:int = 0;
         var MarkerId:int = 0;
         var DirIndex:int = 0;
         var DistIndex:int = 0;
         var DirOffset:Array = null;
         if(this.BallTrackMarkersSpawned)
         {
            for(MarkerIndex = 0; MarkerIndex < this.BallTrackMarkerIds.length; MarkerIndex++)
            {
               MarkerId = int(this.BallTrackMarkerIds[MarkerIndex]);
               this.WindowManager.roomEngine.disposeObjectFurniture(this.RoomSession.roomId,MarkerId);
            }
         }
         var BallBoxId:int = int(this.BallTrackMarkerIds[this.BallTrackMarkerIds.length - 1]);
         this.WindowManager.roomEngine.addObjectFurnitureByName(this.RoomSession.roomId,BallBoxId,"bc_block_1",new Vector3d(CenterX,CenterY,CenterZ),new Vector3d(0),0,new EmptyStuffData());
         this.SetFurnitureColorIndex(BallBoxId,13);
         var PitchBoxes:Array = new Array();
         var RoomFurnisForPitch:Array = this.WindowManager.roomEngine.getRoomObjects(this.RoomSession.roomId,10);
         var PitchFurni:* = null;
         var PitchLoc:* = null;
         for each(PitchFurni in RoomFurnisForPitch)
         {
            if(PitchFurni != null && String(PitchFurni.getType()).indexOf("fball_ptch") == 0)
            {
               PitchLoc = PitchFurni.getLocation();
               PitchBoxes.push([int(PitchLoc.x) - 2,int(PitchLoc.y) - 2,int(PitchLoc.x) + 2,int(PitchLoc.y) + 2]);
            }
         }
         var TargetX:int = 0;
         var TargetY:int = 0;
         var IsOnPitch:Boolean = false;
         var BoxIndex:int = 0;
         var PitchBox:Array = null;
         MarkerIndex = 0;
         for(DirIndex = 0; DirIndex < Directions.length; DirIndex++)
         {
            DirOffset = Directions[DirIndex];
            for(DistIndex = 1; DistIndex <= LineLength; DistIndex++)
            {
               MarkerId = int(this.BallTrackMarkerIds[MarkerIndex]);
               TargetX = CenterX + int(DirOffset[0]) * DistIndex;
               TargetY = CenterY + int(DirOffset[1]) * DistIndex;
               IsOnPitch = PitchBoxes.length == 0;
               for(BoxIndex = 0; BoxIndex < PitchBoxes.length; BoxIndex++)
               {
                  PitchBox = PitchBoxes[BoxIndex];
                  if(TargetX >= PitchBox[0] && TargetX <= PitchBox[2] && TargetY >= PitchBox[1] && TargetY <= PitchBox[3])
                  {
                     IsOnPitch = true;
                     break;
                  }
               }
               if(IsOnPitch)
               {
                  this.WindowManager.roomEngine.addObjectFurnitureByName(this.RoomSession.roomId,MarkerId,"tile_marble",new Vector3d(TargetX,TargetY,CenterZ),new Vector3d(0),0,new EmptyStuffData());
                  this.SetFurnitureAlpha(MarkerId,0.4);
               }
               MarkerIndex++;
            }
         }
         this.BallTrackMarkersSpawned = true;
      }

      private function ClearBallTrackMarkers() : void
      {
         var MarkerIndex:int = 0;
         var MarkerId:int = 0;
         if(this.BallTrackMarkersSpawned == false)
         {
            return;
         }
         for(MarkerIndex = 0; MarkerIndex < this.BallTrackMarkerIds.length; MarkerIndex++)
         {
            MarkerId = int(this.BallTrackMarkerIds[MarkerIndex]);
            this.WindowManager.roomEngine.disposeObjectFurniture(this.RoomSession.roomId,MarkerId);
         }
         this.BallTrackMarkersSpawned = false;
         this.BallTrackLastTileX = -9999;
         this.BallTrackLastTileY = -9999;
      }

      private function FindFballBallId() : int
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return 0;
         }
         var KnownBallTypes:Array = ["fball_ball","fball_ball2","fball_ball3","fball_ball4","fball_ball5"];
         var RoomFurnis:Array = this.WindowManager.roomEngine.getRoomObjects(this.RoomSession.roomId,10);
         var CurrentFurni:* = null;
         for each(CurrentFurni in RoomFurnis)
         {
            if(CurrentFurni != null && KnownBallTypes.indexOf(CurrentFurni.getType()) != -1)
            {
               return int(CurrentFurni.getId());
            }
         }
         return 0;
      }

      private function UseMilkBowls() : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         var RoomFurnis:Array = this.WindowManager.roomEngine.getRoomObjects(this.RoomSession.roomId,10);
         var CurrentFurni:* = null;
         this.MilkBowlQueue = new Array();
         for each(CurrentFurni in RoomFurnis)
         {
            if(CurrentFurni != null && CurrentFurni.getType() == "milkbowl")
            {
               this.MilkBowlQueue.push(int(CurrentFurni.getId()));
            }
         }
         this.MilkBowlTimer.stop();
         if(this.MilkBowlQueue.length > 0)
         {
            this.MilkBowlTimer.start();
         }
      }

      private function MilkBowlTimerHandler(e:TimerEvent) : void
      {
         if(this.PetTalkActive == false || this.IsRoomSessionAvailable == false || this.MilkBowlQueue.length == 0)
         {
            this.MilkBowlTimer.stop();
            return;
         }
         var NextBowlId:int = int(this.MilkBowlQueue.shift());
         this.WindowManager.roomEngine.useRoomObjectInActiveRoom(NextBowlId,10);
         if(this.MilkBowlQueue.length == 0)
         {
            this.MilkBowlTimer.stop();
         }
      }

      private function PetChatTimerHandler(e:TimerEvent) : void
      {
         if(this.PetTalkActive == false || this.IsRoomSessionAvailable == false || this.PetChatQueue.length == 0)
         {
            this.PetChatTimer.stop();
            return;
         }
         var NextMessage:String = String(this.PetChatQueue.shift());
         this.RoomSession.sendChatMessage(NextMessage,this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle);
         if(this.PetChatQueue.length == 0)
         {
            this.PetChatTimer.stop();
         }
      }

      private function ToggleFurniHide() : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         var CurrentFurni:* = null;
         var FurniLocation:* = null;
         var FurniDirection:* = null;
         var SavedEntry:Object = null;
         var RoomFurnis:Array = null;
         if(this.FurniHideActive == false)
         {
            this.HiddenFurniData = new Array();
            RoomFurnis = this.WindowManager.roomEngine.getRoomObjects(this.RoomSession.roomId,10);
            for each(CurrentFurni in RoomFurnis)
            {
               if(CurrentFurni != null && this.EssentialFballTypes.indexOf(CurrentFurni.getType()) == -1)
               {
                  FurniLocation = CurrentFurni.getLocation();
                  FurniDirection = CurrentFurni.getDirection();
                  SavedEntry = {
                     "id":int(CurrentFurni.getId()),
                     "type":String(CurrentFurni.getType()),
                     "x":Number(FurniLocation.x),
                     "y":Number(FurniLocation.y),
                     "z":Number(FurniLocation.z),
                     "dir":Number(FurniDirection.x),
                     "state":int(CurrentFurni.getState(0)),
                     "color":int(CurrentFurni.getModel().getNumber("furniture_color"))
                  };
                  this.HiddenFurniData.push(SavedEntry);
                  this.WindowManager.roomEngine.disposeObjectFurniture(this.RoomSession.roomId,SavedEntry.id);
               }
            }
            this.FurniHideActive = true;
            this.ShowWhisperAlert("Mobílias não essenciais escondidas! (" + this.HiddenFurniData.length + " itens)");
         }
         else
         {
            for each(SavedEntry in this.HiddenFurniData)
            {
               this.WindowManager.roomEngine.addObjectFurnitureByName(this.RoomSession.roomId,SavedEntry.id,SavedEntry.type,new Vector3d(SavedEntry.x,SavedEntry.y,SavedEntry.z),new Vector3d(SavedEntry.dir),SavedEntry.state,new EmptyStuffData());
               this.SetFurnitureColorIndex(SavedEntry.id,SavedEntry.color);
            }
            this.HiddenFurniData = new Array();
            this.FurniHideActive = false;
            this.ShowWhisperAlert("Mobílias restauradas!");
         }
      }

      private function AutoClickTimerHandler(e:TimerEvent) : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         var CurrentFurnitureLocation:* = null;
         var CurrentUserLocation:* = null;
         var CurrentAutoClickObjectIndex:int = int(this.AutoClickObjectsIds.indexOf(this.AutoClickCurrentObjectId));
         var NearClickValue:int = 1;
         if(CurrentAutoClickObjectIndex == -1)
         {
            this.AutoClickCurrentObjectId = this.AutoClickObjectsIds[0];
         }
         if(true == true)
         {
            CurrentUserLocation = this.GetOwnUserLocation();
            CurrentFurnitureLocation = this.GetFurnitureLocation(this.AutoClickCurrentObjectId);
            if(this.GetFurnitureLaySitStand(this.AutoClickCurrentObjectId) == false)
            {
               if(this.GetFurnitureType(this.AutoClickCurrentObjectId) == "one_way_door")
               {
                  NearClickValue = 0;
               }
               if(this.IsPointNearPoint(CurrentUserLocation,CurrentFurnitureLocation,NearClickValue) == false)
               {
                  this.WindowManager.roomEngine.useRoomObjectInActiveRoom(this.AutoClickCurrentObjectId,10);
                  return;
               }
            }
            else if(this.IsPointNearPoint(CurrentUserLocation,CurrentFurnitureLocation,0) == false)
            {
               this.WindowManager.communication.connection.send(new MoveAvatarMessageComposer(CurrentFurnitureLocation.x,CurrentFurnitureLocation.y));
               return;
            }
         }
         if(CurrentAutoClickObjectIndex >= this.AutoClickObjectsIds.length - 1)
         {
            this.AutoClickCurrentObjectId = this.AutoClickObjectsIds[0];
         }
         else
         {
            this.AutoClickCurrentObjectId = this.AutoClickObjectsIds[CurrentAutoClickObjectIndex + 1];
         }
         if(this.GetFurnitureLaySitStand(this.AutoClickCurrentObjectId) == false)
         {
            this.WindowManager.roomEngine.useRoomObjectInActiveRoom(this.AutoClickCurrentObjectId,10);
         }
         else
         {
            CurrentFurnitureLocation = this.GetFurnitureLocation(this.AutoClickCurrentObjectId);
            this.WindowManager.communication.connection.send(new MoveAvatarMessageComposer(CurrentFurnitureLocation.x,CurrentFurnitureLocation.y));
         }
      }
      
      public function GetFurnitureLocation(param1:int) : *
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return null;
         }
         var RequestedFurniture:* = this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,param1,10);
         if(RequestedFurniture)
         {
            return RequestedFurniture.getLocation();
         }
         return null;
      }
      
      public function GetFurnitureState(param1:int) : int
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return null;
         }
         var RequestedFurniture:* = this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,param1,10);
         if(RequestedFurniture)
         {
            return RequestedFurniture.getState(0);
         }
         return null;
      }
      
      public function GetFurnitureType(param1:int) : String
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return null;
         }
         var RequestedFurniture:* = this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,param1,10);
         if(RequestedFurniture)
         {
            return RequestedFurniture.getType();
         }
         return null;
      }
      
      public function GetOwnUserLocation() : *
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return null;
         }
         var RequestedRoomSession:* = this.RoomSession;
         var RequestedUser:* = this.WindowManager.roomEngine.getRoomObject(RequestedRoomSession.roomId,RequestedRoomSession.ownUserRoomId,100);
         if(RequestedUser)
         {
            return RequestedUser.getLocation();
         }
         return null;
      }
      
      public function IsPointNearPoint(param1:*, param2:*, param3:int = 1) : Boolean
      {
         var PointXDiff:Number = Math.abs(param1.x - param2.x);
         var PointYDiff:Number = Math.abs(param1.y - param2.y);
         if(PointXDiff < param3 + 1 && PointYDiff < param3 + 1)
         {
            return true;
         }
         return false;
      }
      
      public function GetFurnitureLaySitStand(param1:int) : Boolean
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return false;
         }
         var RequestedFurniture:* = this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,param1,10);
         var RequestedFurnitureTypeId:* = 0;
         var RequestedFurnitureData:* = null;
         if(RequestedFurniture)
         {
            RequestedFurnitureTypeId = int(RequestedFurniture.getModel().getNumber("furniture_type_id"));
            RequestedFurnitureData = this.WindowManager.sessionDataManager.getFloorItemData(RequestedFurnitureTypeId);
            if(RequestedFurnitureData)
            {
               if(RequestedFurnitureData.canLayOn || RequestedFurnitureData.canSitOn || RequestedFurnitureData.canStandOn)
               {
                  return true;
               }
               return false;
            }
         }
         return false;
      }
      
      public function GetFurnitureUsagePolicy(param1:int) : int
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return 0;
         }
         var RequestedFurniture:* = this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,param1,10);
         var RequestedFurnitureTypeId:* = 0;
         var RequestedFurnitureData:* = null;
         if(RequestedFurniture)
         {
            return int(RequestedFurniture.getModel().getNumber("furniture_usage_policy"));
         }
         return 0;
      }
      
      public function SetFurnitureColorIndex(param1:int, param2:int) : Boolean
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return false;
         }
         var RequestedFurniture:* = this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,param1,10);
         if(RequestedFurniture)
         {
            RequestedFurniture.getModel().setNumber("furniture_color",param2,true);
            return true;
         }
         return false;
      }

      public function SetFurnitureAlpha(param1:int, param2:Number) : Boolean
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return false;
         }
         var RequestedFurniture:* = this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,param1,10);
         if(RequestedFurniture)
         {
            RequestedFurniture.getModel().setNumber("furniture_alpha_multiplier",param2,true);
            return true;
         }
         return false;
      }
      
      public function get RoomObjectHighLighter() : *
      {
         if(this.ObjectHighlighter == null)
         {
            this.ObjectHighlighter = new com.sulake.habbo.roomevents.wired_setup.RoomObjectHighLighter(this.WindowManager.roomEngine.toolbar.roomUI.desktop.userDefinedRoomEvents);
         }
         return this.ObjectHighlighter;
      }
      
      public function ToggleObjectHighLigther(param1:Boolean) : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         var HighlightedObjectId:int = 0;
         var UpdatedHighlightedObjectsIds:Array = new Array();
         for each(HighlightedObjectId in this.HighlightedObjectsIds)
         {
            if(this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,HighlightedObjectId,10) != null)
            {
               UpdatedHighlightedObjectsIds.push(HighlightedObjectId);
            }
         }
         this.HighlightedObjectsIds = UpdatedHighlightedObjectsIds.concat();
         if(param1 == false)
         {
            this.AutoClickSelectionRequested = false;
            this.ObjectHighlighterEnabled = false;
            this.ToggleHighlightedObjectsVisibility(this.HighlightedObjectsIds,false);
            this.HighlightedObjectsIds.length = 0;
         }
         else
         {
            this.ToggleHighlightedObjectsVisibility(this.HighlightedObjectsIds,true);
            this.ObjectHighlighterEnabled = true;
         }
      }
      
      public function OnRoomObjectMouseEvent(param1:*, param2:*, param3:*) : Boolean
      {
         if(param1 == null || param2 == null || param3 == null)
         {
            return false;
         }
         if(this.FurniDoubleClickEnabled == false && param1.type == "doubleClick")
         {
            return false;
         }
         return true;
      }
      
      public function HandleAddedObject(param1:*) : *
      {
         if(this.IsRoomSessionAvailable)
         {
            this.LastAddedObjectId = param1.id;
         }
         else
         {
            this.LastAddedObjectId = 0;
         }
         return param1;
      }
      
      public function HandleRemovedObject(param1:*) : void
      {
         if(this.LastAddedObjectId == param1.id)
         {
            this.LastAddedObjectId = 0;
         }
      }
      
      public function HandleClickedObject(param1:*) : void
      {
         if(LinkPortRequested == true)
         {
            if(int(LatestClickedFurnitureID) > 0 && int(param1.id) > 0)
            {
               this.WindowManager.communication.connection.send(new WiredSetObjectVariableValueMessageComposer(0,LatestClickedFurnitureID,"~103",param1.id,0));
               ShowWhisperAlert("Teleport link request ready!");
               LinkPortRequested = false;
            }
         }
         LatestClickedFurnitureID = param1.id;
         if(this.UseFurniOnSingleClickEnabled)
         {
            this.WindowManager.roomEngine.useRoomObjectInActiveRoom(LatestClickedFurnitureID,10);
         }
         if(this.ObjectHighlighterEnabled == true)
         {
            if(param1.category != 10)
            {
               return;
            }
            if(this.HighlightedObjectsIds.indexOf(param1.id) == -1)
            {
               if(this.HighlightedObjectsIds.length <= this.ObjectHighlighterIdsLimit - 1)
               {
                  this.HighlightedObjectsIds.push(param1.id);
                  this.RoomObjectHighLighter.show(param1.id,false,100);
               }
            }
            else
            {
               this.RoomObjectHighLighter.hide(param1.id,false,100);
               this.HighlightedObjectsIds.splice(this.HighlightedObjectsIds.indexOf(param1.id),1);
            }
         }
      }
      
      private function DevWarTimerHandler(e:TimerEvent) : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         var ActiveRoomSession:* = undefined;
         var ActiveRoomUserData:* = undefined;
         if(this.DevWarIsOpen == true)
         {
            return;
         }
         if(this.DevWarUserFigure == "")
         {
            this.DevWarTimer.stop();
         }
         else
         {
            ActiveRoomSession = this.RoomSession;
            ActiveRoomUserData = ActiveRoomSession.userDataManager.getUserDataByIndex(ActiveRoomSession.ownUserRoomId);
            if(ActiveRoomUserData != null)
            {
               ActiveRoomUserData.figure = this.DevWarUserFigure;
               ActiveRoomUserData.sex = this.DevWarUserSex;
               this.WindowManager.roomEngine.updateObjectUserFigure(ActiveRoomSession.roomId,ActiveRoomSession.ownUserRoomId,ActiveRoomUserData.figure,ActiveRoomUserData.sex);
               if(this.DevWarAdvicePending)
               {
                  this.DevWarAdvicePending = false;
                  this.ShowWhisperAlert("Developer wardrobe enabled! If you use it for server-side purposes (like taking photos) you may be penalized, use at your own risk.");
                  this.ShowWhisperAlert("To recover your real look say :stopdevwar or use the original wardrobe.");
               }
            }
         }
      }
      
      public function LoadSavedVariablesValues() : void
      {
         this.UpdateVariablesValues(true,false,false);
      }
      
      public function SaveVariablesValues() : void
      {
         this.UpdateVariablesValues(false,true,false);
      }
      
      public function ResetVariablesValues() : void
      {
         this.UpdateVariablesValues(false,false,true);
      }
      
      public function UpdateVariablesValues(isLoad:Boolean, isSave:Boolean, isReset:Boolean) : void
      {
         if(isSave)
         {
            this.ClearSavedVariables();
         }
         String("Remember that some objects types like int dont accept null as default value! To avoid that declare object type as * (universal) or set a real default value.");
         this.UpdateVariableValue("IsNavigatorFilterEnabled",true,isLoad,isSave,isReset);
         this.UpdateVariableValue("DevWarUserFigure","",isLoad,isSave,isReset);
         this.UpdateVariableValue("DevWarUserSex","",isLoad,isSave,isReset);
         this.UpdateVariableValue("ShowAllChatBubbles",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("CustomChatSize",12,isLoad,isSave,isReset);
         this.UpdateVariableValue("IsChatEnabled",true,isLoad,isSave,isReset);
         this.UpdateVariableValue("InfoStandDisabled",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("ShowObjectsIds",false,isLoad,isSave,isReset);
         if(SeasonalColorsActive == false || isSave == false)
         {
            this.UpdateVariableValue("TitleBarColor",this.HexToUintColor("#C13270"),isLoad,isSave,isReset);
            this.UpdateVariableValue("BottomBarColor",this.HexToUintColor("#751E4B"),isLoad,isSave,isReset);
            this.UpdateVariableValue("WindowBlend","1.0",isLoad,isSave,isReset);
            this.UpdateVariableValue("BottomBarBlend","0.5",isLoad,isSave,isReset);
            this.UpdateVariableValue("BottomBarAltStyleEnabled",false,isLoad,isSave,isReset);
         }
         this.UpdateVariableValue("IsPlayingEnabled",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("UserCustomFx",0,isLoad,isSave,isReset);
         this.UpdateVariableValue("AntiAfkModeActivated",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("PingBeforeText","Ping: ",isLoad,isSave,isReset);
         this.UpdateVariableValue("PingAfterText","",isLoad,isSave,isReset);
         this.UpdateVariableValue("PingBubble","auto",isLoad,isSave,isReset);
         this.UpdateVariableValue("AnimationFpsUnlocked",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("DesiredFpsValue",60,isLoad,isSave,isReset);
         this.UpdateVariableValue("RoomBackgroundColors",null,isLoad,isSave,isReset);
         this.UpdateVariableValue("RoomLight",-1,isLoad,isSave,isReset);
         this.UpdateVariableValue("RoomBacklight",-1,isLoad,isSave,isReset);
         this.UpdateVariableValue("AdBlockActivated",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("ChatTypingEnabled",true,isLoad,isSave,isReset);
         this.UpdateVariableValue("ShowCriticalErrors",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("ShowQuestsIds",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("SpoofBubbles","",isLoad,isSave,isReset);
         this.UpdateVariableValue("HotKeysDictionary",null,isLoad,isSave,isReset);
         this.UpdateVariableValue("CommandInputColorHintActivated",true,isLoad,isSave,isReset);
         this.UpdateVariableValue("ChatTextColorEnabled",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("FurniDoubleClickEnabled",true,isLoad,isSave,isReset);
         this.UpdateVariableValue("ZoomGesturesEnabled",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("IsTurnBlockEnabled",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("IsWCUBlockEnabled",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("RoomDisplayLowFpsBoost","auto",isLoad,isSave,isReset);
         this.UpdateVariableValue("FriendHighlightEnabled",true,isLoad,isSave,isReset);
         this.UpdateVariableValue("FriendOnlineNotification",2,isLoad,isSave,isReset);
         this.UpdateVariableValue("ShiftWalkBlockEnabled",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("CtrlUseFurniOnSingleClickEnabled",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("HideIgnoredBubbleEnabled",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("SeasonalColorsEnabled",true,isLoad,isSave,isReset);
         this.UpdateVariableValue("HotKeyPressMode","up",isLoad,isSave,isReset);
         this.UpdateVariableValue("MutePetsEnabled",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("MuteBotsEnabled",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("MuteCommandsEnabled",false,isLoad,isSave,isReset);
         this.UpdateVariableValue("DesiredRoomFractionalSize",1,isLoad,isSave,isReset);
         this.UpdateVariableValue("ModCautionAlertsEnabled",true,isLoad,isSave,isReset);
         this.UpdateVariableValue("SavedLooksDictionary",null,isLoad,isSave,isReset);
      }
      
      public function UpdateVariableValue(param1:String, param2:Object, param3:Boolean, param4:Boolean, param5:Boolean) : void
      {
         var VariableName:String = param1;
         var DefaultValue:Object = param2;
         var isLoad:Boolean = param3;
         var isSave:Boolean = param4;
         var isReset:Boolean = param5;
         var AirPlusSharedObject:* = null;
         try
         {
            if(isReset)
            {
               this[VariableName] = DefaultValue;
               return;
            }
            AirPlusSharedObject = SharedObject.getLocal("HabboAirPlus","/");
            if(isLoad)
            {
               if(AirPlusSharedObject.data.hasOwnProperty(VariableName))
               {
                  this[VariableName] = AirPlusSharedObject.data[VariableName];
               }
               else
               {
                  this[VariableName] = DefaultValue;
               }
               return;
            }
            if(isSave)
            {
               AirPlusSharedObject.data[VariableName] = this[VariableName];
               AirPlusSharedObject.flush();
               return;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function ClearSavedVariables() : void
      {
         var AirPlusSharedObject:* = null;
         try
         {
            AirPlusSharedObject = SharedObject.getLocal("HabboAirPlus","/");
            if(AirPlusSharedObject != null)
            {
               AirPlusSharedObject.clear();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      internal function ExportAirPlusSolFile() : void
      {
         var solFile:File = File.applicationStorageDirectory.resolvePath("#SharedObjects/HabboAirPlus.sol");
         if(!solFile.exists)
         {
            ShowWhisperAlert("AirPlus sol file not found!");
            return;
         }
         var bytes:ByteArray = new ByteArray();
         var stream:FileStream = new FileStream();
         stream.open(solFile,FileMode.READ);
         stream.readBytes(bytes,0,stream.bytesAvailable);
         stream.close();
         var fr:FileReference = new FileReference();
         fr.save(bytes,"HabboAirPlus.sol");
      }
      
      internal function ImportAirPlusSolFile() : void
      {
         this.WindowManager.confirm("Confirmation","Do you want to import HabboAirPlus.sol file now?\n\nClient will close immediately, and you will need to reopen it manually.",0,this.SolImportConfirm);
      }
      
      internal function OnSolSelectImport(e:Event) : void
      {
         AirPlusSolImportFR.addEventListener(Event.COMPLETE,OnSolLoadCompleteImport);
         AirPlusSolImportFR.load();
      }
      
      internal function OnSolLoadCompleteImport(e:Event) : void
      {
         var bytes:ByteArray = AirPlusSolImportFR.data;
         var solFile:File = File.applicationStorageDirectory.resolvePath("#SharedObjects/HabboAirPlus.sol");
         var stream:FileStream = new FileStream();
         stream.open(solFile,FileMode.WRITE);
         stream.writeBytes(bytes,0,bytes.length);
         stream.close();
         NativeApplication.nativeApplication.exit(0);
      }
      
      private function SolImportConfirm(param1:*, param2:*) : void
      {
         if(param2.type == "WE_OK")
         {
            AirPlusSolImportFR = new FileReference();
            AirPlusSolImportFR.addEventListener(Event.SELECT,OnSolSelectImport);
            AirPlusSolImportFR.browse([new FileFilter("Shared Object","*.sol")]);
         }
         param1.dispose();
      }
      
      private function ResetVarsConfirm(param1:*, param2:*) : void
      {
         if(param2.type == "WE_OK")
         {
            this.ResetVariablesValues();
            this.SaveVariablesValues();
            this.ShowWhisperAlert("Client variables were reset!");
            this.RecolorWindowFrames();
         }
         param1.dispose();
      }
      
      public function onPingResponse(PingResponse:InterstitialMessageEvent) : void
      {
         var PingResponseTimestamp:int = int(getTimer());
         var PingResponseDelay:int = PingResponseTimestamp - this.PingRequestTimestamp;
         var PingSayBubbleColor:int = 0;
         if(this.PingSay == false)
         {
            this.ShowWhisperAlert(this.PingBeforeText + PingResponseDelay + this.PingAfterText);
         }
         else
         {
            if(PingResponseDelay <= 100)
            {
               PingSayBubbleColor = int("6");
            }
            if(PingResponseDelay > 100 && PingResponseDelay <= 200)
            {
               PingSayBubbleColor = int("5");
            }
            if(PingResponseDelay > 200)
            {
               PingSayBubbleColor = int("3");
            }
            if(this.PingBubble != "auto")
            {
               PingSayBubbleColor = int(this.PingBubble);
            }
            this.RoomSession.sendChatMessage(this.PingBeforeText + PingResponseDelay + this.PingAfterText,PingSayBubbleColor);
         }
         this.ClearPingRequestData();
      }
      
      public function ClearPingRequestData() : void
      {
         this.WindowManager.communication.removeHabboConnectionMessageEvent(this.PingResponseMessageEvent);
         this.PingResponseMessageEvent.dispose();
         this.PingResponseMessageEvent = null;
      }
      
      public function get RoomSession() : *
      {
         if(this.WindowManager.roomEngine == null)
         {
            return null;
         }
         var ActiveRoomID:int = int(this.WindowManager.roomEngine.activeRoomId);
         return this.WindowManager.roomEngine.roomSessionManager.getSession(ActiveRoomID);
      }
      
      public function get IsRoomSessionAvailable() : Boolean
      {
         if(this.RoomSession == null)
         {
            return false;
         }
         return true;
      }
      
      public function ShowWhisperAlert(TextOutput:String) : void
      {
         if(this.IsRoomSessionAvailable == false || MuteCommandsEnabled == true)
         {
            return;
         }
         var ChatStyleId:int = 34;
         this.WindowManager.roomEngine.roomSessionManager.events.dispatchEvent(new RoomSessionChatEvent("RSCE_CHAT_EVENT",this.RoomSession,this.RoomSession.ownUserRoomId,TextOutput,0,ChatStyleId,null));
      }
      
      public function FixNullSplitItems(SplitArray:Array, MinFixCount:int) : void
      {
         var i:int = 0;
         if(SplitArray.length > MinFixCount)
         {
            MinFixCount = int(SplitArray.length);
         }
         while(i <= MinFixCount)
         {
            if(SplitArray[i] == null)
            {
               SplitArray[i] = "";
            }
            i++;
         }
      }
      
      public function RecolorWindowFrames() : void
      {
         var WindowChild:* = null;
         var WindowChildrens:* = this.WindowManager.getDesktop(1).children;
         if(WindowChildrens)
         {
            for each(WindowChild in WindowChildrens)
            {
               this.HandleWindowFrameColor(WindowChild);
            }
         }
      }
      
      public function HandleWindowFrameColor(param1:*) : void
      {
         var WindowFrame:* = param1;
         try
         {
            if(WindowFrame.type == 35)
            {
               WindowFrame.color = this.TitleBarColor;
               WindowFrame.blend = Number(WindowBlend);
            }
            if(WindowFrame.name == "CustomBarColor")
            {
               if(BottomBarAltStyleEnabled)
               {
                  WindowFrame.style = 3;
                  WindowFrame.blend = Number(BottomBarBlend);
               }
               else
               {
                  WindowFrame.style = 9;
                  WindowFrame.blend = 1;
               }
               WindowFrame.color = this.BottomBarColor;
            }
            this.HandleWindowTopHeaderColor(WindowFrame);
         }
         catch(err:Error)
         {
         }
      }
      
      public function HandleWindowTopHeaderColor(WindowFrame:*) : void
      {
         var ClassicTitleBarColor:uint = this.HexToUintColor("#418DB0");
         var ClassicBottomBarColor:uint = this.HexToUintColor("#686661");
         var ClassicTopPartColor:uint = this.HexToUintColor("#0e3f52");
         var BuildersClubTitleBarColor:uint = Number("16758076");
         var BuildersClubTopPartColor:uint = Number("4281149220");
         var AlphaColorAddon:uint = Number("4278190080");
         var TopParts:Array = null;
         var TopPart:String = null;
         var WindowFrameChild:* = null;
         if(WindowFrame.children)
         {
            for each(WindowFrameChild in WindowFrame.children)
            {
               if(WindowFrameChild.name != null && WindowFrameChild.color != null && WindowFrameChild.caption == "")
               {
                  TopParts = ["top_part","header.background.body","header.background.border","header_region","header_container","name_background","header_border","header_inner"];
                  for each(TopPart in TopParts)
                  {
                     if(this.EndsWith(WindowFrameChild.name,TopPart))
                     {
                        if(this.WindowManager.roomEngine.catalog.catalogType == "BUILDERS_CLUB" && WindowFrameChild.name.indexOf("catalog.header.background") == 0)
                        {
                           if(this.TitleBarColor == ClassicTitleBarColor)
                           {
                              WindowFrame.parent.color = BuildersClubTitleBarColor;
                           }
                           WindowFrameChild.color = BuildersClubTopPartColor;
                        }
                        else if(this.BottomBarColor == ClassicBottomBarColor)
                        {
                           WindowFrameChild.color = ClassicTopPartColor + AlphaColorAddon;
                        }
                        else
                        {
                           WindowFrameChild.color = this.BottomBarColor + AlphaColorAddon;
                        }
                     }
                  }
               }
               if(WindowFrameChild.children)
               {
                  this.HandleWindowTopHeaderColor(WindowFrameChild);
               }
            }
         }
      }
      
      internal function EndsWith(mainString:String, suffix:String) : Boolean
      {
         var suffixIndex:int = int(mainString.lastIndexOf(suffix));
         return suffixIndex != -1 && suffixIndex == mainString.length - suffix.length;
      }
      
      public function HexToUintColor(HexColor:String) : uint
      {
         return uint(parseInt(HexColor.replace("#",""),16));
      }
      
      private function OpenAprilFoolsConfirm(param1:*, param2:*) : void
      {
         if(param2.type == "WE_OK")
         {
            this.WindowManager.communication.connection.send(new RequestABadgeComposer("oaerOr"));
            this.WindowManager.communication.connection.send(new RequestABadgeComposer("YhbgMp"));
         }
         param1.dispose();
      }
      
      public function GetChatInputElement() : *
      {
         return this.WindowManager.roomEngine.toolbar.roomUI.desktop.getWidget("RWE_CHAT_INPUT_WIDGET").mainWindow.findChildByName("chat_input");
      }
      
      public function HideAllUsersWithPoints(param1:int) : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         var currentRoomObject:* = undefined;
         var currentRoomObjectData:* = undefined;
         var roomObjectsArray:Array = this.WindowManager.roomEngine.getRoomObjects(this.RoomSession.roomId,100);
         for each(currentRoomObject in roomObjectsArray)
         {
            currentRoomObjectData = this.RoomSession.userDataManager.getUserDataByIndex(currentRoomObject.getId());
            if(currentRoomObjectData.achievementScore <= param1)
            {
               this.WindowManager.roomEngine.disposeObjectUser(this.RoomSession.roomId,currentRoomObjectData.roomObjectId);
               this.RoomSession.userDataManager.removeUserDataByRoomIndex(currentRoomObjectData.roomObjectId);
            }
         }
      }
      
      public function HideAllUsersWithFigure(param1:String) : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         var currentRoomObject:* = undefined;
         var currentRoomObjectData:* = undefined;
         var roomObjectsArray:Array = this.WindowManager.roomEngine.getRoomObjects(this.RoomSession.roomId,100);
         for each(currentRoomObject in roomObjectsArray)
         {
            currentRoomObjectData = this.RoomSession.userDataManager.getUserDataByIndex(currentRoomObject.getId());
            if(currentRoomObjectData.figure == param1)
            {
               this.WindowManager.roomEngine.disposeObjectUser(this.RoomSession.roomId,currentRoomObjectData.roomObjectId);
               this.RoomSession.userDataManager.removeUserDataByRoomIndex(currentRoomObjectData.roomObjectId);
            }
         }
      }
      
      public function ParseChatInput(RoomWidgetMessage:*) : Boolean
      {
         var ActiveRoomSession:* = undefined;
         var ActiveRoomUserData:* = undefined;
         var RequestedFurniture:* = undefined;
         var ChatInput:String = RoomWidgetMessage.text;
         var ChatInputSplit:Array = ChatInput.split(" ");
         this.FixNullSplitItems(ChatInputSplit,5);
         if(ChatInputSplit.length > 0)
         {
            ChatInputSplit[0] = ChatInputSplit[0].toLowerCase();
            String("Commands:");
            if(ChatInputSplit[0] == ":navfilter")
            {
               if(this.IsNavigatorFilterEnabled)
               {
                  this.ShowWhisperAlert("Room navigator filter disabled!");
                  this.IsNavigatorFilterEnabled = false;
               }
               else
               {
                  this.IsNavigatorFilterEnabled = true;
                  this.ShowWhisperAlert("Room navigator filter enabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":solimp")
            {
               ImportAirPlusSolFile();
               return false;
            }
            if(ChatInputSplit[0] == ":solexp")
            {
               ExportAirPlusSolFile();
               return false;
            }
            if(ChatInputSplit[0] == ":showfps")
            {
               this.WindowManager.roomEngine.toolbar.roomUI.desktop.getWidget("RWE_CHAT_INPUT_WIDGET").sendChat(":showstats",0,"",this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle);
               return false;
            }
            if(ChatInputSplit[0] == ":totem")
            {
               if(TotemTimer.running == false)
               {
                  if(GetFurnitureType(LatestClickedFurnitureID) == "lt_r26_totem3" || GetFurnitureType(LatestClickedFurnitureID) == "totem_planet")
                  {
                     TotemFurni = [LatestClickedFurnitureID,GetFurnitureLocation(LatestClickedFurnitureID),GetFurnitureState(LatestClickedFurnitureID),0];
                     TotemTimer.start();
                     ShowWhisperAlert("Totem helper started!");
                  }
                  else
                  {
                     ShowWhisperAlert("Unsupported furni!");
                  }
               }
               else
               {
                  TotemFurni[3] = -1;
               }
               return false;
            }
            if(ChatInputSplit[0] == ":rescam")
            {
               WindowManager.sessionDataManager.setRoomCameraFollowDisabled(false);
               RoomCameraFollowDisablerTimer.reset();
               RoomCameraFollowDisablerTimer.start();
               return false;
            }
            if(ChatInputSplit[0] == ":savelook")
            {
               SaveLook(ChatInput.substring(ChatInputSplit[0].length + 1));
               return false;
            }
            if(ChatInputSplit[0] == ":removelook")
            {
               RemoveSavedLook(ChatInput.substring(ChatInputSplit[0].length + 1));
               return false;
            }
            if(ChatInputSplit[0] == ":clearlooks")
            {
               this.SavedLooksDictionary = new Dictionary();
               this.SaveVariablesValues();
               ShowWhisperAlert("Saved looks cleared!");
               return false;
            }
            if(ChatInputSplit[0] == ":uselook")
            {
               var RequestedLook:String = GetSavedLook(ChatInput.substring(ChatInputSplit[0].length + 1));
               if(RequestedLook != "")
               {
                  this.WindowManager.sessionDataManager.send(new UpdateFigureDataMessageComposer(RequestedLook.split(" ")[0],RequestedLook.split(" ")[1]));
                  ShowWhisperAlert("Requested look loaded!");
               }
               else
               {
                  ShowWhisperAlert("Requested look is empty!");
               }
               return false;
            }
            if(ChatInputSplit[0] == ":showlooks")
            {
               ShowSavedLooks();
               return false;
            }
            if(ChatInputSplit[0] == ":linkport" || ChatInputSplit[0] == ":portlink")
            {
               if(LinkPortRequested == true)
               {
                  LinkPortRequested = false;
                  ShowWhisperAlert("Teleport link canceled!");
                  return false;
               }
               if(int(LatestClickedFurnitureID) > 0)
               {
                  LinkPortRequested = true;
                  ShowWhisperAlert("Click the other teleport you want to connect");
               }
               return false;
            }
            if(ChatInputSplit[0] == ":hidefigures")
            {
               ActiveRoomSession = this.RoomSession;
               ActiveRoomUserData = ActiveRoomSession.userDataManager.getUserDataByIndex(this.WindowManager.roomEngine.getSelectedAvatarId());
               if(ActiveRoomUserData != null)
               {
                  HideAllUsersWithFigure(ActiveRoomUserData.figure);
                  ShowWhisperAlert("All users with that figure will now be temporarily hidden and muted!");
               }
               else
               {
                  ShowWhisperAlert("You must select a user!");
               }
               return false;
            }
            if(ChatInputSplit[0] == ":hidepoints")
            {
               HideAllUsersWithPoints(int(ChatInputSplit[1]));
               ShowWhisperAlert("All users with that activity points will now be temporarily hidden and muted!");
               return false;
            }
            if(ChatInputSplit[0] == ":caution")
            {
               if(ModCautionAlertsEnabled == true)
               {
                  ModCautionAlertsEnabled = false;
                  ShowWhisperAlert("Moderation caution alerts disabled!");
               }
               else
               {
                  ShowWhisperAlert("Moderation caution alerts enabled!");
                  ModCautionAlertsEnabled = true;
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":clearhist")
            {
               this.WindowManager.roomEngine.toolbar.freeFlowChat.visible = false;
               this.WindowManager.roomEngine.toolbar.freeFlowChat.GetChatHistoryBuffer().entries.length = 0;
               return false;
            }
            if(ChatInputSplit[0] == ":clearchat")
            {
               this.WindowManager.roomEngine.toolbar.freeFlowChat.clear();
               return false;
            }
            if(ChatInputSplit[0] == ":mutecmd")
            {
               if(MuteCommandsEnabled == true)
               {
                  MuteCommandsEnabled = false;
                  ShowWhisperAlert("Mute commands disabled!");
               }
               else
               {
                  ShowWhisperAlert("Mute commands enabled!");
                  MuteCommandsEnabled = true;
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":mutepets")
            {
               if(MutePetsEnabled == true)
               {
                  MutePetsEnabled = false;
                  ShowWhisperAlert("Mute pets disabled!");
               }
               else
               {
                  MutePetsEnabled = true;
                  ShowWhisperAlert("Mute pets enabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":mutebots")
            {
               if(MuteBotsEnabled == true)
               {
                  MuteBotsEnabled = false;
                  ShowWhisperAlert("Mute Bots disabled!");
               }
               else
               {
                  MuteBotsEnabled = true;
                  ShowWhisperAlert("Mute Bots enabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":furnitech")
            {
               this.WindowManager.roomEngine.context.createLinkEvent("selfdonation/open");
               return false;
            }
            if(ChatInputSplit[0] == ":hkmode")
            {
               if(HotKeyPressMode == "up")
               {
                  HotKeyPressMode = "down";
                  ShowWhisperAlert("HotKey press mode changed to KeyDown!");
               }
               else
               {
                  HotKeyPressMode = "up";
                  ShowWhisperAlert("HotKey press mode changed to KeyUp!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":seasonal")
            {
               if(SeasonalColorsEnabled)
               {
                  this.LoadSavedVariablesValues();
                  this.RecolorWindowFrames();
                  SeasonalColorsEnabled = false;
                  ShowWhisperAlert("Client seasonal colors disabled!");
               }
               else
               {
                  SeasonalColorsEnabled = true;
                  ShowWhisperAlert("Client seasonal colors enabled! You need to reload the client to see changes.");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":laugh")
            {
               this.RoomSession.sendAvatarExpressionMessage(3);
               return false;
            }
            if(ChatInputSplit[0] == ":spawn")
            {
               FakeFurniId += 1;
               ChatInputSplit[3] = ChatInputSplit[1].split("*")[1];
               ChatInputSplit[1] = ChatInputSplit[1].split("*")[0];
               this.WindowManager.roomEngine.addObjectFurnitureByName(this.RoomSession.roomId,FakeFurniId,ChatInputSplit[1],this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,this.RoomSession.ownUserRoomId,100).getLocation(),this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,this.RoomSession.ownUserRoomId,100).getDirection(),int(ChatInputSplit[2]),new EmptyStuffData());
               if(ChatInputSplit[3] != undefined)
               {
                  SetFurnitureColorIndex(FakeFurniId,int(ChatInputSplit[3]));
               }
               return false;
            }
            if(ChatInputSplit[0] == ":hideignoredbubble")
            {
               if(HideIgnoredBubbleEnabled)
               {
                  HideIgnoredBubbleEnabled = false;
                  this.WindowManager.roomEngine.setProperty("avatar.ignored.bubble.enabled","true");
                  ShowWhisperAlert("Hide ignored users bubble disabled! You may need to reload the room to see changes!");
               }
               else
               {
                  HideIgnoredBubbleEnabled = true;
                  this.WindowManager.roomEngine.setProperty("avatar.ignored.bubble.enabled","false");
                  ShowWhisperAlert("Hide ignored users bubble enabled! You may need to reload the room to see changes!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":ctrl")
            {
               if(CtrlUseFurniOnSingleClickEnabled)
               {
                  CtrlUseFurniOnSingleClickEnabled = false;
                  ShowWhisperAlert("Ctrl key to use furnitures on single click disabled!");
               }
               else
               {
                  CtrlUseFurniOnSingleClickEnabled = true;
                  ShowWhisperAlert("Ctrl key to use furnitures on single click enabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":shift" || ChatInputSplit[0] == ":swb")
            {
               if(ShiftWalkBlockEnabled)
               {
                  ShiftWalkBlockEnabled = false;
                  RoomObjectMouseKeyboardShortcutsEnabled = true;
                  WalkEnabled = true;
                  ShowWhisperAlert("Shift key to walk block disabled!");
               }
               else
               {
                  ShiftWalkBlockEnabled = true;
                  ShowWhisperAlert("Shift key to walk block enabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":dc")
            {
               if(this.UseFurniOnSingleClickEnabled == false)
               {
                  this.UseFurniOnSingleClickEnabled = true;
                  this.ShowWhisperAlert("Use furnitures on single click enabled!");
               }
               else
               {
                  this.UseFurniOnSingleClickEnabled = false;
                  this.ShowWhisperAlert("Use furnitures on single click disabled!");
               }
               return false;
            }
            if(ChatInputSplit[0] == ":fon")
            {
               FriendOnlineNotification = Number(ChatInputSplit[1]);
               if(FriendOnlineNotification > 2)
               {
                  FriendOnlineNotification = 2;
               }
               if(FriendOnlineNotification == 0)
               {
                  ShowWhisperAlert("Friends online notification disabled!");
               }
               if(FriendOnlineNotification == 1)
               {
                  ShowWhisperAlert("Friends online notification enabled for all!");
               }
               if(FriendOnlineNotification == 2)
               {
                  ShowWhisperAlert("Friends online notification enabled for relationships!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":winblend")
            {
               if(ChatInputSplit[1] == "")
               {
                  ChatInputSplit[1] = "1.0";
               }
               WindowBlend = String(Number(ChatInputSplit[1]));
               this.RecolorWindowFrames();
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":barblend")
            {
               if(BottomBarAltStyleEnabled == false)
               {
                  this.ShowWhisperAlert("To use :barblend you must enable :barstyle first!!");
                  return false;
               }
               if(ChatInputSplit[1] == "")
               {
                  ChatInputSplit[1] = "0.5";
               }
               BottomBarBlend = String(Number(ChatInputSplit[1]));
               this.RecolorWindowFrames();
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":barstyle")
            {
               if(BottomBarAltStyleEnabled == false)
               {
                  BottomBarAltStyleEnabled = true;
                  this.ShowWhisperAlert("Bottom bar alternative style enabled!");
               }
               else
               {
                  BottomBarAltStyleEnabled = false;
                  this.ShowWhisperAlert("Bottom bar alternative style disabled!");
               }
               this.RecolorWindowFrames();
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":friendhl")
            {
               if(this.FriendHighlightEnabled == false)
               {
                  this.FriendHighlightEnabled = true;
                  this.ShowWhisperAlert("Friend name entrance highlight enabled!");
               }
               else
               {
                  this.FriendHighlightEnabled = false;
                  this.ShowWhisperAlert("Friend name entrance highlight disabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":furni")
            {
               IsFurniChooserOpen = true;
            }
            if(ChatInputSplit[0] == ":chooser")
            {
               IsUserChooserOpen = true;
            }
            if(ChatInputSplit[0] == ":crash")
            {
               ShowWhisperAlert("Critical error invoked!");
               crash();
               return false;
            }
            if(ChatInputSplit[0] == ":aprilfools")
            {
               this.WindowManager.confirm("Confirmation","Do you want to request \'april fools 2025\' badges? Use at your own risk.",0,this.OpenAprilFoolsConfirm);
               return false;
            }
            if(ChatInputSplit[1] == ":clickfurni" || ChatInputSplit[1] == ":usefurni" || ChatInputSplit[1] == ":movetofurni")
            {
               if(ChatInputSplit[2] == "")
               {
                  ChatInput += " " + int(LatestClickedFurnitureID);
               }
            }
            if(ChatInputSplit[1] == ":clickuser")
            {
               if(ChatInputSplit[2] == "")
               {
                  ChatInput += " " + int(this.WindowManager.roomEngine.getSelectedAvatarId());
               }
            }
            if(ChatInputSplit[0] == ":clickuser")
            {
               if(ChatInputSplit[1] != "0" && int(ChatInputSplit[1]) == 0)
               {
                  ChatInputSplit[1] = int(this.WindowManager.roomEngine.getSelectedAvatarId());
               }
               if(int(ChatInputSplit[1]) >= 0)
               {
                  this.WindowManager.communication.connection.send(new WiredClickUserMessageComposer(int(ChatInputSplit[1])));
               }
               return false;
            }
            if(ChatInputSplit[0] == ":clickfurni")
            {
               if(int(ChatInputSplit[1]) == 0)
               {
                  ChatInputSplit[1] = int(LatestClickedFurnitureID);
               }
               RequestedFurniture = this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,int(ChatInputSplit[1]),10);
               if(RequestedFurniture)
               {
                  this.WindowManager.communication.connection.send(new ClickFurniMessageComposer(int(ChatInputSplit[1])));
               }
               return false;
            }
            if(ChatInputSplit[0] == ":usefurni")
            {
               if(int(ChatInputSplit[1]) == 0)
               {
                  ChatInputSplit[1] = int(LatestClickedFurnitureID);
               }
               RequestedFurniture = this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,int(ChatInputSplit[1]),10);
               if(RequestedFurniture)
               {
                  this.WindowManager.roomEngine.useRoomObjectInActiveRoom(int(ChatInputSplit[1]),10);
               }
               return false;
            }
            if(ChatInputSplit[0] == ":movetofurni")
            {
               if(int(ChatInputSplit[1]) == 0)
               {
                  ChatInputSplit[1] = int(LatestClickedFurnitureID);
               }
               RequestedFurniture = this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,int(ChatInputSplit[1]),10);
               if(RequestedFurniture)
               {
                  this.WindowManager.communication.connection.send(new MoveAvatarMessageComposer(RequestedFurniture.getLocation().x,RequestedFurniture.getLocation().y));
               }
               return false;
            }
            if(ChatInputSplit[0] == ":fpsboost")
            {
               if(ChatInputSplit[1] == "auto" || ChatInputSplit[1] == "always" || ChatInputSplit[1] == "never")
               {
                  RoomDisplayLowFpsBoost = ChatInputSplit[1];
               }
               else
               {
                  RoomDisplayLowFpsBoost = "auto";
               }
               this.ShowWhisperAlert("Low fps boost set to " + RoomDisplayLowFpsBoost);
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":zoomf")
            {
               if(Number(ChatInputSplit[1]) == 0)
               {
                  ChatInputSplit[1] = "1.0";
               }
               this.WindowManager.roomEngine.getActiveRoomActiveCanvas().setScale(Number(ChatInputSplit[1]));
               DesiredRoomFractionalSize = Number(ChatInputSplit[1]);
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":wcublock")
            {
               if(this.IsWCUBlockEnabled == false)
               {
                  this.IsWCUBlockEnabled = true;
                  this.ShowWhisperAlert("WiredClickUser block enabled!");
               }
               else
               {
                  this.IsWCUBlockEnabled = false;
                  this.ShowWhisperAlert("WiredClickUser block disabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":turnblock")
            {
               if(this.IsTurnBlockEnabled == false)
               {
                  this.IsTurnBlockEnabled = true;
                  this.ShowWhisperAlert("Avatar turn block enabled!");
               }
               else
               {
                  this.IsTurnBlockEnabled = false;
                  this.ShowWhisperAlert("Avatar turn block disabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":chatalarm")
            {
               if(ChatInputSplit[1] == "")
               {
                  this.ShowWhisperAlert("Chat alarm disabled!");
               }
               else
               {
                  this.ShowWhisperAlert("Chat alarm enabled!");
               }
               ChatAlarmText = ChatInputSplit[1];
               return false;
            }
            if(ChatInputSplit[0] == ":walkblock")
            {
               if(WalkEnabled)
               {
                  WalkEnabled = false;
                  this.ShowWhisperAlert("Walk block enabled!");
               }
               else
               {
                  WalkEnabled = true;
                  this.ShowWhisperAlert("Walk block disabled!");
               }
               return false;
            }
            if(ChatInputSplit[0] == ":tradeblock")
            {
               if(TradeEnabled)
               {
                  TradeEnabled = false;
                  TradeBlockTimer.start();
                  this.ShowWhisperAlert("Trade block enabled!");
               }
               else
               {
                  TradeEnabled = true;
                  TradeBlockTimer.stop();
                  this.ShowWhisperAlert("Trade block disabled!");
               }
               if(IsTradingOpen)
               {
                  this.WindowManager.communication.connection.send(new CloseTradingComposer());
               }
               return false;
            }
            if(ChatInputSplit[0] == ":flood")
            {
               if(ChatInputSplit[1] != "")
               {
                  this.FloodText = ChatInput.substring(ChatInputSplit[0].length + 1);
                  this.FloodTimer.start();
                  this.ShowWhisperAlert("Flood enabled!");
               }
               else
               {
                  this.FloodTimer.stop();
                  this.ShowWhisperAlert("Flood disabled!");
               }
               return false;
            }
            if(ChatInputSplit[0] == ":flooddelay" || ChatInputSplit[0] == ":floodelay")
            {
               if(int(ChatInputSplit[1]) > 100)
               {
                  this.FloodTimer.delay = int(ChatInputSplit[1]);
               }
               else
               {
                  this.FloodTimer.delay = 100;
               }
               this.ShowWhisperAlert("Flood delay set to " + this.FloodTimer.delay + " ms.");
               return false;
            }
            if(ChatInputSplit[0] == ":abctest")
            {
               this.WindowManager.localization.GetSingletonAbcTag3().LilithCustomsInstance.ShowWhisperAlert("@red@Hello world from AbcTag3 |");
               SingletonAbcTag4.GetLilithCustoms().ShowWhisperAlert("@green@Hello world from AbcTag4 |");
               return false;
            }
            if(ChatInputSplit[0] == ":zoomgestures")
            {
               if(this.ZoomGesturesEnabled == false)
               {
                  this.ZoomGesturesEnabled = true;
                  this.ShowWhisperAlert("Zoom gestures enabled!  You may need to reload the room to see changes!");
               }
               else
               {
                  this.ZoomGesturesEnabled = false;
                  this.ShowWhisperAlert("Zoom gestures disabled!  You may need to reload the room to see changes!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":nodc")
            {
               if(this.FurniDoubleClickEnabled == false)
               {
                  this.FurniDoubleClickEnabled = true;
                  this.ShowWhisperAlert("Furniture double click enabled!");
               }
               else
               {
                  this.FurniDoubleClickEnabled = false;
                  this.ShowWhisperAlert("Furniture double click disabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":about" || ChatInputSplit[0] == ":version")
            {
               this.WindowManager.roomEngine.context.createLinkEvent("LilithCustoms/About");
               return false;
            }
            if(ChatInputSplit[0] == ":chatcolor")
            {
               if(this.ChatTextColorEnabled == false)
               {
                  this.ChatTextColorEnabled = true;
                  this.ShowWhisperAlert("Users chat text color enabled!");
               }
               else
               {
                  this.ChatTextColorEnabled = false;
                  this.ShowWhisperAlert("Users chat text color disabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":cmdcolor")
            {
               if(this.CommandInputColorHintActivated == false)
               {
                  this.CommandInputColorHintActivated = true;
                  this.ShowWhisperAlert("Command input color hint activated!");
               }
               else
               {
                  this.CommandInputColorHintActivated = false;
                  this.ShowWhisperAlert("Command input color hint deactivated!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":commands")
            {
               this.WindowManager.roomEngine.context.createLinkEvent("habbopages/chat/commands");
               return false;
            }
            if(ChatInputSplit[0].indexOf(":f") == 0)
            {
               ChatInputSplit[0] = ChatInputSplit[0].substr(2);
               if(int(ChatInputSplit[0]) >= 1 && int(ChatInputSplit[0]) <= 12)
               {
                  this.HotKeyPendingValue = ChatInput.substring(ChatInputSplit[0].length + 3);
                  this.SetHotKey(111 + int(ChatInputSplit[0]));
                  return false;
               }
               ChatInputSplit[0] = ":f" + ChatInputSplit[0];
            }
            if(ChatInputSplit[0] == ":hkclear")
            {
               this.HotKeyPendingToSet = false;
               this.HotKeyPendingValue = "";
               this.HotKeysDictionary = new Dictionary();
               this.SaveVariablesValues();
               this.ShowWhisperAlert("Hotkeys clear ready!");
               return false;
            }
            if(ChatInputSplit[0] == ":hkshow" || ChatInputSplit[0] == ":showhk")
            {
               if(this.HotKeysDictionary != null)
               {
                  for(var CurrentHotKeyItem in HotKeysDictionary)
                  {
                     if(HotKeysDictionary[CurrentHotKeyItem] != "undefined" && HotKeysDictionary[CurrentHotKeyItem] != "")
                     {
                        ShowWhisperAlert("Key: " + getKeyNameFromCode(uint(CurrentHotKeyItem)) + "(" + CurrentHotKeyItem + ") -> Value: " + HotKeysDictionary[CurrentHotKeyItem]);
                     }
                  }
               }
               return false;
            }
            if(ChatInputSplit[0] == ":hkset")
            {
               this.HotKeyPendingValue = ChatInput.substring(ChatInputSplit[0].length + 1);
               this.ShowWhisperAlert("Press the key you want to assign!");
               this.HotKeyPendingToSet = true;
               return false;
            }
            if(ChatInputSplit[0] == ":youtube")
            {
               this.WindowManager.roomEngine.toolbar.roomUI.desktop.getWidget("RWE_YOUTUBE").show(null,true);
               return false;
            }
            if(ChatInputSplit[0] == ":vimeo")
            {
               this.WindowManager.roomEngine.toolbar.roomUI.desktop.getWidget("RWE_VIMEO").show(null,true,0);
               return false;
            }
            if(ChatInputSplit[0] == ":give" || ChatInputSplit[0] == ":pass")
            {
               ActiveRoomSession = this.RoomSession;
               ActiveRoomUserData = ActiveRoomSession.userDataManager.getUserDataByIndex(this.WindowManager.roomEngine.getSelectedAvatarId());
               if(ActiveRoomUserData != null)
               {
                  if(ActiveRoomUserData.type == 1)
                  {
                     this.WindowManager.roomEngine.toolbar.roomUI.desktop.processWidgetMessage(new RoomWidgetUserActionMessage("RWUAM_PASS_CARRY_ITEM",ActiveRoomUserData.webID));
                  }
                  if(ActiveRoomUserData.type == 2)
                  {
                     this.WindowManager.roomEngine.toolbar.roomUI.desktop.processWidgetMessage(new RoomWidgetUserActionMessage("RWUAM_GIVE_CARRY_ITEM_TO_PET",ActiveRoomUserData.webID));
                  }
               }
               return false;
            }
            if(ChatInputSplit[0] == ":whisper")
            {
               ActiveRoomSession = this.RoomSession;
               ActiveRoomUserData = ActiveRoomSession.userDataManager.getUserDataByIndex(this.WindowManager.roomEngine.getSelectedAvatarId());
               if(ActiveRoomUserData != null)
               {
                  this.RoomSession.sendWhisperMessage(ActiveRoomUserData.name,ChatInput.substring(ChatInputSplit[0].length + 1),this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle);
               }
               return false;
            }
            if(ChatInputSplit[0] == ":shout")
            {
               this.RoomSession.sendShoutMessage(ChatInput.substring(ChatInputSplit[0].length + 1),this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle);
               return false;
            }
            if(ChatInputSplit[0] == ":say")
            {
               this.RoomSession.sendChatMessage(ChatInput.substring(ChatInputSplit[0].length + 1),this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle);
               return false;
            }
            if(ChatInputSplit[0] == ":acceptquest")
            {
               if(int(ChatInputSplit[1]) > 0)
               {
                  this.WindowManager.sessionDataManager.send(new AcceptQuestMessageComposer(int(ChatInputSplit[1])));
               }
               return false;
            }
            if(ChatInputSplit[0] == ":showquestsids")
            {
               if(this.ShowQuestsIds == false)
               {
                  this.ShowQuestsIds = true;
                  this.ShowWhisperAlert("Show quests ids enabled!");
               }
               else
               {
                  this.ShowQuestsIds = false;
                  this.ShowWhisperAlert("Show quests ids disabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":figure")
            {
               if(ChatInputSplit[2].toUpperCase() != "F" && ChatInputSplit[2].toUpperCase() != "M")
               {
                  ActiveRoomSession = this.RoomSession;
                  ActiveRoomUserData = ActiveRoomSession.userDataManager.getUserDataByIndex(ActiveRoomSession.ownUserRoomId);
                  ChatInputSplit[2] = ActiveRoomUserData.sex;
               }
               if(ChatInputSplit[1].indexOf("-") >= 0)
               {
                  this.WindowManager.sessionDataManager.send(new UpdateFigureDataMessageComposer(ChatInputSplit[1],ChatInputSplit[2]));
                  if(WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(0) != null)
                  {
                     this.WindowManager.roomEngine.toolbar.roomUI.catalog.avatarEditor.loadAvatarInEditor(0,ChatInputSplit[1],ChatInputSplit[2]);
                  }
               }
               return false;
            }
            if(ChatInputSplit[0] == ":rotate")
            {
               RoomRotatingEffect.init(0,0);
               RoomRotatingEffect.turnVisualizationOn();
               return false;
            }
            if(ChatInputSplit[0] == ":spoofbubbles" || ChatInputSplit[0] == ":spoofbubble")
            {
               if(ChatInputSplit[1] == "own")
               {
                  this.SpoofBubbles = "own_" + String(this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle);
                  this.ShowWhisperAlert("Chat bubbles spoofer enabled for own! (ID " + String(this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle) + ")");
               }
               else
               {
                  if(ChatInputSplit[1] != "all")
                  {
                     if(this.SpoofBubbles == "")
                     {
                        this.ShowWhisperAlert("Select a chat bubble style and then say :spoofbubbles own or :spoofbubbles all to enable it!");
                        return false;
                     }
                     this.SpoofBubbles = "";
                     this.ShowWhisperAlert("Chat bubbles spoofer disabled!");
                     this.SaveVariablesValues();
                     return false;
                  }
                  this.SpoofBubbles = "all_" + String(this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle);
                  this.ShowWhisperAlert("Chat bubbles spoofer enabled for all! (ID " + String(this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle) + ")");
               }
               this.SaveVariablesValues();
               String("Faltaria hacer que las burbujas de texto enviadas al servidor tengan el estilo id 0 en lugar de la burbuja falsa.");
               String("Temporalmente asigno el style a 0 manualmente, pero lo malo es que luego si se vuelve a usar el comando figurara como la seleccionada la 0, en lugar de la realmente seleccionada.");
               this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle = 0;
               return false;
            }
            if(ChatInputSplit[0] == ":showerrors")
            {
               if(this.ShowCriticalErrors == false)
               {
                  this.ShowCriticalErrors = true;
                  this.ShowWhisperAlert("Show critical errors enabled!");
               }
               else
               {
                  this.ShowCriticalErrors = false;
                  this.ShowWhisperAlert("Show critical errors disabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":typing")
            {
               if(this.ChatTypingEnabled == false)
               {
                  this.ChatTypingEnabled = true;
                  this.ShowWhisperAlert("Chat typing indicator enabled!");
               }
               else
               {
                  this.ChatTypingEnabled = false;
                  this.RoomSession.sendChatTypingMessage(false);
                  this.ShowWhisperAlert("Chat typing indicator disabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":adblock")
            {
               if(this.AdBlockActivated == false)
               {
                  this.AdBlockActivated = true;
                  this.ShowWhisperAlert("Adblock activated!\nReload the room to apply changes!");
               }
               else
               {
                  this.AdBlockActivated = false;
                  this.ShowWhisperAlert("Adblock deactivated! Reload the room to apply changes!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":roomlight")
            {
               if(ChatInputSplit[1] == "" || ChatInputSplit[1] == "-1")
               {
                  this.RoomLight = -1;
                  this.ShowWhisperAlert("Custom roomlight deactivated!");
               }
               else
               {
                  this.RoomBacklight = -1;
                  this.RoomLight = int(ChatInputSplit[1]);
                  this.ShowWhisperAlert("Custom roomlight activated!");
               }
               this.SaveVariablesValues();
               this.RoomLightTimer.start();
               return false;
            }
            if(ChatInputSplit[0] == ":backlight")
            {
               if(ChatInputSplit[1] == "" || ChatInputSplit[1] == "-1")
               {
                  this.RoomBacklight = -1;
                  this.ShowWhisperAlert("Custom backlight deactivated!");
               }
               else
               {
                  this.RoomLight = -1;
                  this.RoomBacklight = int(ChatInputSplit[1]);
                  this.ShowWhisperAlert("Custom backlight activated!");
               }
               this.SaveVariablesValues();
               this.RoomLightTimer.start();
               return false;
            }
            if(ChatInputSplit[0] == ":bgcolor")
            {
               if(ChatInputSplit[1] == "")
               {
                  this.RoomBackgroundColors = null;
                  this.ShowWhisperAlert("Custom bgcolor deactivated!");
               }
               else
               {
                  this.RoomBackgroundColors = new Array(int(ChatInputSplit[1]),int(ChatInputSplit[2]),int(ChatInputSplit[3]));
                  this.ShowWhisperAlert("Custom bgcolor activated!");
               }
               this.SaveVariablesValues();
               this.RoomBackgroundColorTimer.start();
               return false;
            }
            if(ChatInputSplit[0] == ":fps")
            {
               this.DesiredFpsValue = int(ChatInputSplit[1]);
               if(this.DesiredFpsValue == 0)
               {
                  this.DesiredFpsValue = 60;
               }
               if(this.DesiredFpsValue < 10)
               {
                  this.DesiredFpsValue = 10;
               }
               this.WindowManager.roomEngine.context.displayObjectContainer.stage.frameRate = this.DesiredFpsValue;
               this.ShowWhisperAlert("FPS value was set to " + String(this.DesiredFpsValue));
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":fpsunlock" || ChatInputSplit[0] == ":unlockfps")
            {
               if(this.WindowManager.roomEngine.getRoomCanvasGeometry(this.RoomSession.roomId,1).LockAnimationFPS)
               {
                  this.AnimationFpsUnlocked = true;
                  this.WindowManager.roomEngine.getRoomCanvasGeometry(this.RoomSession.roomId,1).LockAnimationFPS = false;
                  this.ShowWhisperAlert("FPS unlock enabled!");
               }
               else
               {
                  this.AnimationFpsUnlocked = false;
                  this.ShowWhisperAlert("FPS unlock disabled! Reload the room to apply changes!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":respect")
            {
               ActiveRoomSession = this.RoomSession;
               ActiveRoomUserData = ActiveRoomSession.userDataManager.getUserDataByIndex(this.WindowManager.roomEngine.getSelectedAvatarId());
               if(ActiveRoomUserData != null && this.WindowManager.roomEngine.getSelectedAvatarId() != ActiveRoomSession.ownUserRoomId)
               {
                  this.WindowManager.communication.connection.send(new RespectUserMessageComposer(ActiveRoomUserData.webID));
               }
               return false;
            }
            if(ChatInputSplit[0] == ":safetybook")
            {
               this.WindowManager.roomEngine.toolbar.roomUI.habboHelp.showSafetyBooklet();
               return false;
            }
            if(ChatInputSplit[0] == ":habboway")
            {
               this.WindowManager.roomEngine.toolbar.roomUI.habboHelp.showHabboWay();
               return false;
            }
            if(ChatInputSplit[0] == ":handitem")
            {
               ActiveRoomSession = this.RoomSession;
               this.WindowManager.roomEngine.updateObjectUserAction(ActiveRoomSession.roomId,ActiveRoomSession.ownUserRoomId,"figure_carry_object",int(ChatInputSplit[1]));
               return false;
            }
            if(ChatInputSplit[0] == ":calendar")
            {
               this.WindowManager.roomEngine.context.createLinkEvent("openView/calendar");
               return false;
            }
            if(ChatInputSplit[0] == ":linkevent")
            {
               this.WindowManager.roomEngine.context.createLinkEvent(ChatInputSplit[1]);
               return false;
            }
            if(ChatInputSplit[0] == ":givegem")
            {
               ActiveRoomSession = this.RoomSession;
               ActiveRoomUserData = ActiveRoomSession.userDataManager.getUserDataByIndex(this.WindowManager.roomEngine.getSelectedAvatarId());
               if(ActiveRoomUserData != null)
               {
                  if(int(ChatInputSplit[1]) < 1)
                  {
                     ChatInputSplit[1] = "1";
                  }
                  this.FriendGiveGemID = ActiveRoomUserData.webID;
                  this.FriendGiveGemAmount = int(ChatInputSplit[1]);
                  this.WindowManager.confirm("Confirmation","Do you want to give " + String(this.FriendGiveGemAmount) + " gems to " + ActiveRoomUserData.name + "? Use at your own risk.",0,this.FriendGiveGemConfirm);
               }
               return false;
            }
            if(ChatInputSplit[0] == ":lightsaber")
            {
               this.WindowManager.sessionDataManager.sendSpecialCommandMessage(":yyxxabxa");
               return false;
            }
            if(ChatInputSplit[0] == "clear")
            {
               if(this.ObjectHighlighterEnabled)
               {
                  this.ToggleHighlightedObjectsVisibility(this.HighlightedObjectsIds,false);
                  this.HighlightedObjectsIds.length = 0;
                  return false;
               }
               return true;
            }
            if(ChatInputSplit[0] == "ok")
            {
               if(this.AutoClickSelectionRequested)
               {
                  this.AutoClickSelectionRequested = false;
                  this.AutoClickObjectsIds = this.HighlightedObjectsIds.concat();
                  if(this.AutoClickObjectsIds.length != 0)
                  {
                     this.AutoClickCurrentObjectId = 0;
                     this.AutoClickTimer.start();
                     this.ShowWhisperAlert("Autoclick enabled!");
                  }
                  else
                  {
                     this.AutoClickTimer.stop();
                     this.ShowWhisperAlert("Autoclick disabled!");
                  }
                  this.ToggleObjectHighLigther(false);
                  return false;
               }
               return true;
            }
            if(ChatInputSplit[0] == ":autoclickdelay")
            {
               if(int(ChatInputSplit[1]) > 100)
               {
                  this.AutoClickTimer.delay = int(ChatInputSplit[1]);
               }
               else
               {
                  this.AutoClickTimer.delay = 100;
               }
               this.ShowWhisperAlert("AutoClick delay set to " + this.AutoClickTimer.delay + " ms.");
               return false;
            }
            if(ChatInputSplit[0] == ":autoclick")
            {
               this.ToggleObjectHighLigther(false);
               if(this.AutoClickTimer.running == false)
               {
                  this.ObjectHighlighterIdsLimit = 666;
                  this.HighlightedObjectsIds = this.AutoClickObjectsIds.concat();
                  this.AutoClickSelectionRequested = true;
                  this.ToggleObjectHighLigther(true);
                  this.ShowWhisperAlert("Select a furni and then say \"OK\".\nOr say \"CLEAR\" to reset.");
               }
               else
               {
                  this.AutoClickTimer.stop();
                  this.ShowWhisperAlert("Autoclick disabled!");
               }
               return false;
            }
            if(ChatInputSplit[0] == ":devwar")
            {
               this.ShowWhisperAlert("Warning:\nDevwar uses a lot of ram and may crash the client!");
               ActiveRoomSession = this.RoomSession;
               ActiveRoomUserData = ActiveRoomSession.userDataManager.getUserDataByIndex(this.WindowManager.roomEngine.getSelectedAvatarId());
               if(ActiveRoomUserData == null)
               {
                  ActiveRoomUserData = ActiveRoomSession.userDataManager.getUserDataByIndex(ActiveRoomSession.ownUserRoomId);
               }
               this.DevWarIsOpen = true;
               this.DevWarTimer.start();
               this.WindowManager.roomEngine.toolbar.roomUI.catalog.avatarEditor.openEditor(3,null,null,true);
               this.WindowManager.roomEngine.toolbar.roomUI.catalog.avatarEditor.loadAvatarInEditor(3,ActiveRoomUserData.figure,ActiveRoomUserData.sex);
               return false;
            }
            if(ChatInputSplit[0] == ":stopdevwar")
            {
               this.DevWarUserFigure = "";
               this.DevWarUserSex = "";
               ActiveRoomSession = this.RoomSession;
               ActiveRoomUserData = ActiveRoomSession.userDataManager.getUserDataByIndex(ActiveRoomSession.ownUserRoomId);
               ActiveRoomUserData.figure = this.WindowManager.sessionDataManager.figure;
               this.WindowManager.roomEngine.updateObjectUserFigure(ActiveRoomSession.roomId,ActiveRoomSession.ownUserRoomId,this.WindowManager.sessionDataManager.figure,this.WindowManager.sessionDataManager.gender);
               this.DevWarAdvicePending = true;
               this.ShowWhisperAlert("Developer wardrobe disabled!");
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":resetvars")
            {
               this.WindowManager.confirm("Confirmation","Do you want to reset client variables?\n\nYou will lose any saved client settings, including local wardrobe looks.\nBefore continuing, it is recommended to create a backup using the :solexp command.",0,this.ResetVarsConfirm);
               return false;
            }
            if(ChatInputSplit[0] == ":showids")
            {
               if(this.ShowObjectsIds == false)
               {
                  this.ShowObjectsIds = true;
                  this.ShowWhisperAlert("ID viewer activated, reopen chooser/furni dialog to apply changes!");
               }
               else
               {
                  this.ShowObjectsIds = false;
                  this.ShowWhisperAlert("ID viewer deactivated, reopen chooser/furni dialog to apply changes!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":infostand")
            {
               if(this.InfoStandDisabled)
               {
                  this.InfoStandDisabled = false;
                  this.ShowWhisperAlert("InfoStand enabled!");
               }
               else
               {
                  this.InfoStandDisabled = true;
                  this.ShowWhisperAlert("InfoStand disabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":chatmute")
            {
               if(this.IsChatEnabled)
               {
                  this.ShowWhisperAlert("Chat mute enabled!");
                  this.IsChatEnabled = false;
               }
               else
               {
                  this.IsChatEnabled = true;
                  this.ShowWhisperAlert("Chat mute disabled!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":chatsize")
            {
               if(true == true)
               {
                  ShowWhisperAlert("Deprecated command, chat size is now officially included in the chat bubble selector!");
                  return false;
               }
               if(int(ChatInputSplit[1]) < 12)
               {
                  ChatInputSplit[1] = "12";
               }
               if(int(ChatInputSplit[1]) > 40)
               {
                  ChatInputSplit[1] = "40";
               }
               this.CustomChatSize = int(ChatInputSplit[1]);
               this.ShowWhisperAlert("Chat size set to " + ChatInputSplit[1]);
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":pingbeforetext" || ChatInputSplit[0] == ":pingaftertext")
            {
               if(ChatInputSplit[0] == ":pingbeforetext")
               {
                  this.PingBeforeText = ChatInput.slice(ChatInputSplit[0].length + 1);
               }
               else
               {
                  this.PingAfterText = ChatInput.slice(ChatInputSplit[0].length + 1);
               }
               this.ShowWhisperAlert("[Example] " + this.PingBeforeText + "0" + this.PingAfterText);
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":pingbubble" || ChatInputSplit[0] == ":pingubble")
            {
               if(ChatInputSplit[1] != "auto" && this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle > 0)
               {
                  ChatInputSplit[1] = this.WindowManager.roomEngine.toolbar.freeFlowChat.preferedChatStyle;
               }
               else
               {
                  ChatInputSplit[1] = "auto";
               }
               this.PingBubble = ChatInputSplit[1];
               this.ShowWhisperAlert("Chat bubble style set to " + this.PingBubble);
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":showbubbles")
            {
               if(this.ShowAllChatBubbles)
               {
                  this.ShowAllChatBubbles = false;
                  this.ShowWhisperAlert("Show all selector bubbles disabled!");
               }
               else
               {
                  this.ShowAllChatBubbles = true;
                  this.ShowWhisperAlert("Show all selector bubbles enabled!");
               }
               this.SaveVariablesValues();
               this.WindowManager.roomEngine.toolbar.roomUI.desktop.getWidget("RWE_CHAT_INPUT_WIDGET").refreshChatStyles();
               return false;
            }
            if(ChatInputSplit[0] == ":color")
            {
               if(ChatInputSplit[1] == "pink" || ChatInputSplit[1].replace(" ","") == "")
               {
                  ChatInputSplit[1] = "#C13270";
               }
               if(ChatInputSplit[1] == "classic")
               {
                  ChatInputSplit[1] = "#418DB0";
               }
               this.TitleBarColor = this.HexToUintColor(ChatInputSplit[1]);
               this.RecolorWindowFrames();
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":barcolor")
            {
               if(ChatInputSplit[1] == "pink" || ChatInputSplit[1].replace(" ","") == "")
               {
                  ChatInputSplit[1] = "#751E4B";
               }
               if(ChatInputSplit[1] == "classic")
               {
                  ChatInputSplit[1] = "#686661";
               }
               this.BottomBarColor = this.HexToUintColor(ChatInputSplit[1]);
               this.RecolorWindowFrames();
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":ping" || ChatInputSplit[0] == ":pingsay")
            {
               if(getTimer() - this.PingRequestTimestamp <= 1000)
               {
                  this.ShowWhisperAlert("Too fast!");
                  return false;
               }
               if(this.PingResponseMessageEvent == null)
               {
                  this.PingSay = ChatInputSplit[0] == ":pingsay";
                  this.PingResponseMessageEvent = new InterstitialMessageEvent(this.onPingResponse);
                  this.WindowManager.communication.addHabboConnectionMessageEvent(this.PingResponseMessageEvent);
                  this.PingRequestTimestamp = getTimer();
                  this.WindowManager.communication.connection.send(new GetInterstitialMessageComposer());
                  return false;
               }
               if(getTimer() - this.PingRequestTimestamp >= 5000)
               {
                  this.ClearPingRequestData();
                  this.ParseChatInput(ChatInput);
                  return false;
               }
               this.ShowWhisperAlert("Ping check is busy!");
               return false;
            }
            if(ChatInputSplit[0] == ":afk")
            {
               if(this.AntiAfkModeActivated == false)
               {
                  this.AntiAfkModeActivated = true;
                  this.AntiAfkModeTimer.start();
                  this.ShowWhisperAlert("Anti-AFK activated!");
               }
               else
               {
                  this.AntiAfkModeActivated = false;
                  this.AntiAfkModeTimer.stop();
                  this.ShowWhisperAlert("Anti-AFK deactivated!");
               }
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":clone")
            {
               this.CloneSelectedAvatarLook(ChatInputSplit[1]);
               return false;
            }
            if(ChatInputSplit[0] == ":dance")
            {
               this.RoomSession.sendDanceMessage(int(ChatInputSplit[1]));
               return false;
            }
            if(ChatInputSplit[0] == ":sit")
            {
               this.RoomSession.sendChangePostureMessage(1);
               return false;
            }
            if(ChatInputSplit[0] == ":stand")
            {
               this.RoomSession.sendChangePostureMessage(0);
               return false;
            }
            if(ChatInputSplit[0] == ":fx")
            {
               this.UserCustomFx = int(ChatInputSplit[1]);
               if(this.UserCustomFx != 0)
               {
                  this.ShowWhisperAlert("Custom FX activated!");
               }
               else
               {
                  this.ShowWhisperAlert("Custom FX deactivated!");
               }
               this.UserCustomFxTimer.start();
               this.SaveVariablesValues();
               return false;
            }
            if(ChatInputSplit[0] == ":playing")
            {
               if(this.IsPlayingEnabled == false)
               {
                  this.IsPlayingEnabled = true;
                  this.ShowWhisperAlert("Playing/ClickThrough mode activated!");
               }
               else
               {
                  this.IsPlayingEnabled = false;
                  this.ShowWhisperAlert("Playing/ClickThrough mode deactivated!");
               }
               this.SaveVariablesValues();
               this.WindowManager.roomEngine.setIsPlayingGame(this.RoomSession.roomId,IsPlayingEnabled);
               return false;
            }
            if(ChatInputSplit[0] == ":mandiocafrita")
            {
               this.OnMandiocaFrita();
               return false;
            }
            if(ChatInputSplit[0] == ":vip")
            {
               if(this.WindowManager.sessionDataManager.userName.toLowerCase() == "lpit..")
               {
                  this.ShowWhisperAlert("VIP ativo!");
               }
               return false;
            }
            if(ChatInputSplit[0] == ":petfala")
            {
               if(this.PetTalkActive == false)
               {
                  this.PetTalkActive = true;
                  this.PetTalkTimer.delay = 10000;
                  this.PetTalkTimer.reset();
                  this.PetTalkTimer.start();
                  this.ShowWhisperAlert("Modo PetFala ativado! Vou lembrar seus pets de vez em quando.");
               }
               else
               {
                  this.PetTalkActive = false;
                  this.PetTalkTimer.stop();
                  this.MilkBowlTimer.stop();
                  this.MilkBowlQueue = new Array();
                  this.PetChatTimer.stop();
                  this.PetChatQueue = new Array();
                  this.ShowWhisperAlert("Modo PetFala desativado!");
               }
               return false;
            }
            if(ChatInputSplit[0] == ":caixapreta")
            {
               if(this.BallTrackActive == false)
               {
                  var AutoFoundBallId:int = this.FindFballBallId();
                  if(AutoFoundBallId > 0)
                  {
                     this.BallTrackFurniId = AutoFoundBallId;
                  }
                  else if(int(this.LatestClickedFurnitureID) > 0)
                  {
                     this.BallTrackFurniId = int(this.LatestClickedFurnitureID);
                  }
                  else
                  {
                     this.ShowWhisperAlert("Não achei nenhuma bola (fball_ball5) na sala e você não clicou em nada. Clique na bola e tente de novo!");
                     return false;
                  }
                  this.BallTrackActive = true;
                  this.BallTrackLastTileX = -9999;
                  this.BallTrackLastTileY = -9999;
                  this.BallTrackMarkersSpawned = false;
                  this.BallTrackTimer.reset();
                  this.BallTrackTimer.start();
                  this.ShowWhisperAlert("Sinalizador da bola ativado!");
               }
               else
               {
                  this.BallTrackActive = false;
                  this.BallTrackTimer.stop();
                  this.ClearBallTrackMarkers();
                  this.ShowWhisperAlert("Sinalizador da bola desativado!");
               }
               return false;
            }
            if(ChatInputSplit[0] == ":furniture")
            {
               this.ToggleFurniHide();
               return false;
            }
         }
         return true;
      }

      private function AntiAfkModeTimerHandler(e:TimerEvent) : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         if(this.AntiAfkModeActivated == false)
         {
            this.AntiAfkModeTimer.stop();
            return;
         }
         if(int(this.WindowManager.roomEngine.getRoomObject(this.RoomSession.roomId,this.RoomSession.ownUserRoomId,100).getModel().getNumber("figure_dance")) == 0)
         {
            this.RoomSession.sendAvatarExpressionMessage(0);
         }
         else
         {
            this.WindowManager.communication.connection.send(new MoveAvatarMessageComposer(this.CurrentRoomPlaneParser.maxX + 1,this.CurrentRoomPlaneParser.maxY + 1));
         }
      }

      public function OnMandiocaFrita() : void
{
   if(this.WindowManager.sessionDataManager.userName.toLowerCase() != "lpit..")
   {
      return;
   }

   this.MandiocaFritaAtiva = !this.MandiocaFritaAtiva;

   if(this.MandiocaFritaAtiva)
   {
      this.ShowWhisperAlert("Modo MandiocaFrita ativado: cliques otimizados ligados.");
   }
   else
   {
      this.ShowWhisperAlert("Modo MandiocaFrita desativado.");
   }
}

      // ==========================================================================
      // >>> MATHEUS: aqui roda o EFEITO do MandiocaFrita, escreva seu código aqui <<<
      // Chame RunMandiocaFritaEffect(...) de dentro de algum evento que já existe
      // (ex: OnWalkTo, HandleClickedObject, OnRoomChat) para ela disparar sozinha.
      // ==========================================================================
      public function RunMandiocaFritaEffect(tileX:int, tileY:int) : void
      {
         if(this.MandiocaFritaAtiva == false)
         {
            return;
         }

         // TODO: seu código continua aqui embaixo (pode usar tileX e tileY)
      }
      // ==========================================================================
      // <<< FIM efeito MandiocaFrita >>>
      // ==========================================================================

      public function CloneSelectedAvatarLook(AvatarSex:String = "") : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         var SelectedAvatarData:* = null;
         var SelectedAvatarID:int = int(this.WindowManager.roomEngine.getSelectedAvatarId());
         if(SelectedAvatarID > -1)
         {
            SelectedAvatarData = this.RoomSession.userDataManager.getUserDataByIndex(SelectedAvatarID);
            if(SelectedAvatarData != null)
            {
               AvatarSex = AvatarSex.toUpperCase();
               if(AvatarSex != "F" && AvatarSex != "M")
               {
                  AvatarSex = "";
               }
               if(AvatarSex == "")
               {
                  AvatarSex = SelectedAvatarData.sex;
               }
               this.WindowManager.sessionDataManager.send(new UpdateFigureDataMessageComposer(SelectedAvatarData.figure,AvatarSex));
               if(WindowManager.roomEngine.toolbar.catalog.avatarEditor.getEditor(0) != null)
               {
                  this.WindowManager.roomEngine.toolbar.roomUI.catalog.avatarEditor.loadAvatarInEditor(0,SelectedAvatarData.figure,AvatarSex);
               }
            }
         }
      }
      
      private function UserCustomFxTimerHandler(e:TimerEvent) : void
      {
         if(this.IsRoomSessionAvailable == false)
         {
            return;
         }
         this.WindowManager.roomEngine.setAvatarEffect(this.UserCustomFx);
         if(this.UserCustomFx == 0)
         {
            this.UserCustomFxTimer.stop();
         }
      }
   }
}

