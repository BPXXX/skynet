local tbl = {}

tbl.EWebMsgType =
{
	--for client:1XXX,for server:2XXX
	MSG_None = 0,
	--for client
	MSG_Request_RoomList  =101,
	MSG_Request_JoinRoom = 102,
	MSG_RequestChat = 103,
	--for server
	MSG_Response_RoomList = 201,
	MSG_Response_JoinRoom = 202,
	MSG_Response_Chat = 203
};

tbl.ERoomType = 
{
	RType_None = 0,
	RType_Commercial = 1,
	RType_Personal = 2,
}

return tbl