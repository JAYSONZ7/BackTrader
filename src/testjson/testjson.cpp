#include <iostream>
#include <fstream>
#include <cstdio>
#include "../third_party/rapidjson/include/rapidjson/document.h"
#include "../third_party/rapidjson/include/rapidjson/stringbuffer.h"
#include "../third_party/rapidjson/include/rapidjson/writer.h"
#include "../third_party/rapidjson/include/rapidjson/filereadstream.h"
#include "../third_party/rapidjson/include/rapidjson/filewritestream.h"

using namespace rapidjson;

void testJson()
{
    // Parse a JSON string into DOM.
    const char *t_json = "{\"function\":\"testJson\",\"number\":100}";
    Document d;
    d.Parse(t_json);

    // Modify it by DOM.
    Value &s = d["number"];
    s.SetInt(s.GetInt() + 1);

    // Stringify the DOM
    StringBuffer buffer;
    Writer<StringBuffer> writer(buffer);
    d.Accept(writer);
    const char *t_jsonOut = buffer.GetString();
    std::cout << t_jsonOut << std::endl;
}

void testJsonFile()
{
    const char *t_json = "{\"function\":\"testJsonFile\",\"files\":20}";
    Document dw;
    dw.Parse(t_json);

    FILE *fp1 = fopen("test.json", "w");
    char writeBuffer[65536];
    FileWriteStream os(fp1, writeBuffer, sizeof(writeBuffer));
    Writer<FileWriteStream> writer(os);
    dw.Accept(writer);
    fclose(fp1);

    FILE *fp2 = std::fopen("test.json", "r");
    char readBuffer[65536];
    FileReadStream is(fp2, readBuffer, sizeof(readBuffer));
    Document dr;
    dr.ParseStream(is);
    std::fclose(fp2);
    std::cout << "Read JSON from file: " << dr["function"].GetString() << ", files: " << dr["files"].GetInt() << std::endl;
}

int main(int argc, char *argv[])
{
    std::cout << "start test json" << std::endl;

    testJson();
    testJsonFile();

    std::cout << "Please press any key..." << std::endl;
    std::cin.get();

    return 0;
}
