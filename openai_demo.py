# -*- coding: utf-8 -*-

from openai import OpenAI

messages = [
    {"role": "system", "content": "请你扮演绩效评估师,可以针对我所提供的数据给出专业的综合评价和发展建议"},
]

# 初始化OpenAI客户端
client = OpenAI(
    base_url="https://api.xty.app/v1",
    api_key="sk-mxKD3SATH7XCyZN6D803C201DfD3408793D7EcEaB2407dF3",
)

def chat():
    while True:
        user_input = input('User:')
        messages.append({"role": "user", "content": user_input})
        response = client.chat.completions.create(
            model="gpt-3.5-turbo", messages=messages, stream=True)
        answer = ''
        for chunk in response:
            token = chunk.choices[0].delta.content
            if token != None:
                answer += token
                print(token, end='')

        messages.append({"role": "assistant", "content": answer})
        print()
        

def Generate_Evaluation_Report_By_AI(question):
    messages.append({"role": "user", "content": question})
    response = client.chat.completions.create(
        model="gpt-3.5-turbo", messages=messages, stream=True)
    answer = ''
    for chunk in response:
        token = chunk.choices[0].delta.content
        if token is not None:  # 使用 is not None 而不是 != None 是更好的做法
            answer += token
            # print(token, end='')  # 这一行已被注释掉，因此不会打印到终端

    messages.append({"role": "assistant", "content": answer})

    return answer


        
if __name__ == '__main__':
    # chat()
    
    question = "教师绩效目标:该学期参与2次会议,产出2篇学术成果,任课平均成绩达到60分以上,及格率达到80%; 学生反馈与评价:该教师上课风格耐心、循序渐进、授课内容丰富、教学方法灵活,对待同学认真负责,教学效果优秀。； 同事反馈与评价:该教师授课风格独特,深入浅出,深受学生喜爱,授课内容丰富,教学方法灵活,对学生的学习效果尤其好。； 教研组长评价:该教师授课风格独特,深入浅出,深受学生喜爱,授课内容丰富,教学方法灵活,对学生的学习效果尤其好。； 本人总结:这学期我参与了3次学术交流会,发表了2篇学术论文,并取得了不错的成绩。但是所带班级的成绩不太理想,需要继续努力。请根据上述内容给出针对该教师的综合评价和发展建议,综合评价和发展建议分开写,均不超过500字"
    answer = Generate_Evaluation_Report_By_AI(question)
    print("Answer:", answer)
